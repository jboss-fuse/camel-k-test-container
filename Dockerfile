FROM docker.io/golang:1.17

COPY runTest.sh /opt/runTest.sh

RUN curl -o oc.tar.gz -O https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz && tar xzvf oc.tar.gz -C /usr/local/bin
RUN go install github.com/jstemmer/go-junit-report@latest

CMD [ "/opt/runTest.sh" ]