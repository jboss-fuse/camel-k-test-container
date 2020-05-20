#!/usr/bin/env bash

if [ ! -z "${KUBERNETEST_API_URL}" ]; then
    oc login --token "${KUBERNETES_API_TOKEN}" "${KUBERNETEST_API_URL}" --insecure-skip-tls-verify=true
fi

cd /opt/enmasse
mvn test -pl systemtests -am -P$PROFILE -Djava.net.preferIPv4Stack=true -DfailIfNoTests=false -Dstyle.color=always -DskipTests --no-transfer-progress -Dtest=$TESTCASE
cp /opt/enmasse/systemtests/target/surefire-reports/*.xml /test-run-results
ls /test-run-results