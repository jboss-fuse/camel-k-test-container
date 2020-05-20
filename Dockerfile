FROM docker.io/library/maven:3.6.3-jdk-11

COPY entry-point.sh /opt/entry-point.sh

ARG REPO="https://github.com/EnMasseProject/enmasse.git"
ARG BRANCH="master"

ENV PROFILE=smoke
ENV TESTCASE=""

ENV KUBERNETES_API_TOKEN=""
ENV KUBERNETEST_API_URL=""
ENV KUBERNETES_DOMAIN=""
ENV KUBERNETES_NAMESPACE=enmasse-infra

ENV SKIP_UNINSTALL=true


RUN apt -qq update
RUN apt -qq install make gcc -y git

RUN wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz -q
RUN tar xf go1.13.3.linux-amd64.tar.gz
RUN mv go /usr/local
ENV PATH="${PATH}:/usr/local/go/bin"

RUN wget https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz -q
RUN tar xf oc.tar.gz
RUN mv oc /usr/bin/oc

RUN mkdir /test-run-results
RUN git clone --single-branch --branch ${BRANCH} ${REPO}
RUN mv enmasse /opt/enmasse


ENTRYPOINT [ "/opt/entry-point.sh" ]