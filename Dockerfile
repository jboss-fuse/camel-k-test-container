FROM docker.io/golang:1.17

COPY runTest.sh /opt/runTest.sh

CMD [ "/opt/runTest.sh" ]