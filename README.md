# Camel-K test container
container for [Delorean](https://github.com/integr8ly/delorean) tests of Camel-K

### running tests 
```
./delorean tests run -o `pwd` --test-config ./test-containers.yaml
```
#### test-containers.yaml
```
---
tests:
  - name: camel-k
    image: quay.io/jbouska/camel-k-test-container:latest
    timeout: 3600
    envVars:
      - name: NAMESPACE
        value: camel-k-namespace
      - name: KAMEL_CLI
        value: https://mirror.openshift.com/pub/openshift-v4/clients/camel-k/1.0/camel-k-client-1.0-linux-64bit.tar.gz
```
