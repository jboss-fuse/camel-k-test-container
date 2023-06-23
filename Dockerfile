FROM docker.io/golang:1.17

COPY runTest.sh /opt/runTest.sh

ENV OC_VERSION=4.13
RUN wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/fast-${OC_VERSION}/openshift-client-linux.tar.gz \
    -O /tmp/openshift-client.tar.gz &&\
    tar xzf /tmp/openshift-client.tar.gz -C /usr/bin oc &&\
    rm /tmp/openshift-client.tar.gz

RUN go install github.com/jstemmer/go-junit-report@latest
RUN chmod -R 777 /go 
ENV GOPATH=/go GOCACHE=/go/.cache

CMD [ "/opt/runTest.sh" ]