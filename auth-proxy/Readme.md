# RedHat auth proxy
**RedHat auth proxy** is a proxy that can make use of openshift authentication solutions in order to enable/force users to authenticate for workloads that doesnt support authentication

## Customizing Values file
- clone the Chart folder
- open and edit **values.yaml** file according to the following instructions:
---
**auth.upstream**
- select the target address where to be redirected after authentication.
- target must contain the prefix http/https.
- in case the target is not a DNS record then you need to provide a port with the address

**emailDomain**
- provide an email domain name e.g "redhat.com" where all users with this domain will be able to authenticate successfully

**cookieSecretName**
- select a name for the cookie secret name (the proxy will create this secret)
- proxy name must be 16 bytes or 24 or 32

**cookieRefreshSec**
- selecta numeric value to make the proxy refresh the coockies the value is represented in seconds

**replicas**
- the number of the replicas of the auth proxy to create

**labels**
- provide a list of labels to be added to all resources
- the following is an example of how to decalre the list:
```yaml
  labels:
    - 'someLabelName: someLabelValue'
    - 'someOtherLabelName: someOtherLabelValue'
```
---
## Installation
1. using the currently active project
```bash
#supposing you are in the chart dir
#run:
helm install $RELEASE_NAME ./
#e.g helm install kafdrop-auth-proxy ./
```
2. install in a diffrent project/namespace
	```bash
	#supposing you are in the chart dir
	#run:
	helm install $RELEASE_NAME ./ --namespace=$my_namespace
	#e.g helm install kafdrop-auth-proxy ./ --namespace=redhat-auth-proxy-test
	```
 
---
## for the future
1. add support for ultiple authentication methods to the chart
2. allow user to set a specific set of email addresses to be allowed to authenticate instead of email domain name
