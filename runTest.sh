#!/bin/bash
set -o pipefail

if [ -z "$KAMEL_CLI" ]; then
  echo "[ERROR] KAMEL_CLI variable is not set."
  exit 1
fi

echo "Downloading KAMEL_CLI from ${KAMEL_CLI}"
curl -O ${KAMEL_CLI}
tar xzf ${KAMEL_CLI##*/}
export KAMEL_BIN=${PWD}/kamel

cd acceptance-tests
go test -v ./test/operator/smoke/... 2>&1 | tee report.txt

go get -u github.com/jstemmer/go-junit-report
go-junit-report <report.txt >/test-run-results/report.xml
