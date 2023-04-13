#!/bin/bash
set -o pipefail

OLM_CHANNEL=${OLM_CHANNEL:-latest}
export CAMEL_K_GLOBAL_OPERATOR_NS=${OPERATOR_NS:-'openshift-operators'}

if [[ -z "${VERSION}" ]]; then
  echo "'VERSION' ENV variable is not found - extract it from the cluster (from the '$OLM_CHANNEL' channel)"
  VERSION=$(oc get packagemanifests red-hat-camel-k -o jsonpath="{.status.channels[?(@.name=='${OLM_CHANNEL}')].currentCSVDesc.version}")
  # get rid of the build suffix for operator respins
  VERSION=${VERSION%+?*}
fi

KAMEL_URL=https://mirror.openshift.com/pub/openshift-v4/clients/camel-k/${VERSION}/camel-k-client-${VERSION}-linux-64bit.tar.gz
REPO=https://github.com/apache/camel-k.git
RESULTS_DIR="${TEST_COLLECT_BASE_DIR:=/data/results}"
GOCACHE=/go/.cache


fail() {
  echo "$@" 1>&2
  exit 1
}

download_cli() {
  echo "Downloading KAMEL_CLI from ${KAMEL_URL}"
  curl -L -s -o kamel_cli.tar.gz -O ${KAMEL_URL} && tar xzf kamel_cli.tar.gz || fail "Can't download KAMEL_CLI"
  export KAMEL_BIN=${PWD}/kamel
}

clone_testsuite() {
  echo "Clonning the test suite from $REPO:release-${VERSION%.*}.x"
  git clone -q --single-branch -c http.sslVerify=false --branch release-${VERSION%.*}.x ${REPO}
}

run_test() {
  name="$1"; shift
  go test -timeout 20m -v -tags=integration $@ 2>&1 | tee ${RESULTS_DIR}/${name}.log
  go-junit-report < ${RESULTS_DIR}/${name}.log  > ${RESULTS_DIR}/${name}.xml
}

if [ -z "$VERSION" ]; then
  fail "[ERROR] VERSION variable is not set."
fi

export KAMEL_INSTALL_BUILD_TIMEOUT=15m
export CAMEL_K_TEST_TIMEOUT_SHORT=5m
export CAMEL_K_TEST_TIMEOUT_MEDIUM=15m
export CAMEL_K_TEST_TIMEOUT_LONG=20m
export CAMEL_K_FORCE_GLOBAL_TEST=true

clone_testsuite
download_cli

cd camel-k
run_test common ./e2e/global/common/rest_test.go
run_test traits ./e2e/global/common/traits/route_test.go ./e2e/global/common/traits/prometheus_test.go