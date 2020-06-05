FROM docker.io/golang:1.14

ARG REPO="https://gitlab.cee.redhat.com/jboss-fuse-qe/fuse.next/acceptance-tests.git"
ARG BRANCH="master"

RUN git clone --single-branch -c http.sslVerify=false --branch ${BRANCH} ${REPO}

COPY runTest.sh /opt/runTest.sh

RUN mkdir /test-run-results

CMD [ "/opt/runTest.sh" ]