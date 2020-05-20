# Enmasse test container
container with enmasse systemtests

### running tests
```
docker run --name test-container -e KUBERNETES_API_TOKEN=<TOKEN> -e KUBERNETEST_API_URL=<API_URL> quay.io/enmasse/enmasse-test-container:latest
```

### env variables
```
PROFILE=smoke
TESTCASE=""
KUBERNETES_API_TOKEN=""
KUBERNETEST_API_URL=""
KUBERNETES_DOMAIN=""
KUBERNETES_NAMESPACE=enmasse-infra
SKIP_UNINSTALL=true
```