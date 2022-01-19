---

# Schema Registry
----
## Features
-  deploy redhat schema registry over openshift cluster with dynamic configuration
-  deploy keycloak dynamically for securing the registry
- deploy RH/AuthProxy for securing the registry ui (alternative for keycloak)


---
## SchemaRegistry configuration

```yaml
name: rh-service-registry
bootstrapServers: essence-kafka-demo-kafka-external-bootstrap-kafka-essence-demo.apps.o7pr5dba.westeurope.aroapp.io:443
namespace: kafka-essence-demo
userName: schema-registry-user
clusterName: essence-kafka-demo
domain: apps.o7pr5dba.westeurope.aroapp.io
logLevel: INFO
persistence: kafkasql
labels:
  - 'app: rhsrKeycloakTest'
  - 'dep: rhsrKeycloakTest' 
```
---
- each line of the above yaml snipest from the chart values file will be described below:

#### name:
- this is the name prefix of the shcema registr.

#### bootstrapServers:
- this field is to set the kafka cluster endpoint (mandatory field)

#### namespace:
- the namespace name where to install the schema registry (should be sane as the release namespace).

#### userName:
- in order to give access for the schema registry to the kafka cluster a kafka user get created along with the schema registry, so this field specifies the username of the kafka that will be automatically created.

#### clusterName:
- the kafka cluster name that the schema registry will connect to.

#### domain:
- this key is basically used in order to pre define the route of the KeyCloak cluster, in case you are not using KeyCloak along with the registry no need to set this variable.

#### logLevel:
- set the log level of the SchemaRegistry instance, can be INFO/DEBUG.

#### persistence:
- please declare this field by the chart creator

#### labels:
- list of labels to be add to the chart components, its very adviced to use 3+ unique labels

----

#### common configs for keycloak
- find the KeyCloak section and modify the following depedning on ur needs:
```yaml
keycloak:
  enabled: true
  useRHSSOoperator: true
  enableExternalAccess: true
  instances: 1
```
- set the **enabled** key into false in order to disable keycloak
- set the **enableExternalAccess** key to false in order to disable route creation for the keycloak
- set **instances** key into the number of replicas you want the ketcloak to run
- set the  **useRHSSOoperator** key into false in order to use the keycloak-operator instead of rhsso-operator for managing keycloak deployments
---

### KeyCloak Realm Config
- find the Realm section inside the KeyCloak section and modify the following depedning on ur needs:
```yaml
  realm:
    uiClientID: registry-ui-client
    apiClientID: registry-api-client
    adminUser:
      enabled: true
      name: registry-admin
      password: 'a1s2d3f4'
    developerUser:
      enabled: true
      name: registry-developer
      password: 'a1s2d3f4'
    readerUser:
      enabled: true
      name: registry-user
      password: 'a1s2d3f4'
```
- the above snipest shows the default config of the Realm
- below is the description of each field:
1) **uiClientID** is the client name/id for the ui of the registry inside the Realm inside the KeyCloak (no need to change)
2) **apiClientID** is the client name/id for the api of the registry inside the Realm inside the KeyCloak (no need to change)
3) you will notice **3** replicated sctions (**adminUser, developerUser, readerUser**):
those are the 3 users supported by **apicurio schema registry.**
- each user can be enabled/disabled using the boolean '**enabled**' key
- each suer can have a custom name and this can be set in the '**name**' key
- each user can have a custom password which can be set in the '**password**' key
