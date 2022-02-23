# KafDrop Kafka UI

<!-- markdownlint-disable -->
<a href="https://www.redhat.com/en">
    <img src="https://raw.githubusercontent.com/RHEcosystemAppEng/fsi-common-helm/main/kafdrop/images/KafDrop_UI_Diagram.png" width="800" height="350" alt="">
</a>
<!-- markdownlint-restore -->

[KafDrop][30], is a Java OpenSource project that was built in order to provide a GUI for showind diffrent kafka componnents ,</br>
This Chart was Developed in order to easily install the KafDrop over an OCP/K8S Cluster, plust the ability to support AMQ Streams Kafka Deployments.</br>
And if you're in for the *full* [OpenShift][12] experience,</br>
[AMQ][13] which is also part of [Red Hat's Integration][11] services portfolio,</br>
got your underlying *Kafka* deployment covered with [AMQ Streams][14].

Simply install this *Chart* specifying your KAFKA deployment Properties.</br>
:grin:

## Installation

Adding the repo:

```shell
helm repo add fsi-common-helm https://rhecosystemappeng.github.io/fsi-common-helm/
```
## Configuration Values

Update [values.yaml](values.yaml) or use *helm* to set the following configuration parameters:

| Parameter                    | Description                                                                | Required | Example                                                                                                                                                                                                                                               |
|------------------------------|----------------------------------------------------------------------------|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| replicaCount                 | the number of replication of deployment                                    | N        | 1                                                                                                                                                                                                                                                     |
| namespace                    | the namespace where to install the resources                               | Y        | my-ui-ns                                                                                                                                                                                                                                              |
| image.repository             | the repository where the image exist                                       | N        | obsidiandynamics/kafdrop                                                                                                                                                                                                                              |
| image.tag                    | the tag of the image                                                       | N        | latest                                                                                                                                                                                                                                                |
| image.pullPolicy             | the pull policy (Always/IfNotExist)                                        | N        | Always                                                                                                                                                                                                                                                |
| kafka.brokerConnect          | the endpoint of the kafka cluster that you need to visualize               | Y        | my-kafka-end-point:9093                                                                                                                                                                                                                               |
| kafka.kafkaProperties        | a kafka proberties config, required only if using unsecured kafka cluster  | Y/N      | schema.registry.url=http://rh-service-registry:8080/apis/ccompat/v6 ssl.truststore.location=/etc/kafka/truststore/ca.p12 ssl.truststore.type=PKCS12 ssl.keystore.location=/etc/kafka/keystore/user.p12 ssl.keystore.type=PKCS12 security.protocol=SSL |
| kafka.keystoreFileLocation   | the location where to mount the cluster keystore (AMQ Streams supported)   | Y/N      | /etc/kafka/keystore                                                                                                                                                                                                                                   |
| kafka.keystoreItem           | the file name of the keystore                                              | Y/N      | user.p12                                                                                                                                                                                                                                              |
| kafka.keystoreSecret         | the secret name that contains the KetStore                                 | Y/N      | kafka-admin-user                                                                                                                                                                                                                                      |
| kafka.propertiesFileLocation | where to mount hte kafka properties file specified in line 8               | Y/N      | /etc/kafka                                                                                                                                                                                                                                            |
| kafka.truststoreFileLocation | the location where to mount the cluster TrustStore (AMQ Streams supported) | Y/N      | /etc/kafka/truststore                                                                                                                                                                                                                                 |
| kafka.truststoreItem         | the file name of the TrustStore                                            | Y/N      | ca.p12                                                                                                                                                                                                                                                |
| kafka.truststoreSecret       | the Secret name that contains the Truststore                               | Y/N      | my-demo-kafka-cluster-ca-cert                                                                                                                                                                                                                         |
| jvm.opts                     | set JVM options                                                            | N        | "-Xms32M -Xmx64M"                                                                                                                                                                                                                                     |
| jmx.port                     | set JMX port                                                               | N        | 8686                                                                                                                                                                                                                                                  |
| cmdArgs                      | extra command args, useful when using SchemaRegistry                       | Y/N      | "--message.format=AVRO --schemaregistry.connect=http://rh-service-registry:8080/apis/ccompat/v6"                                                                                                                                                      |
| service.type                 | the type of the K8S Service that will route to the Pods                    | N        | ClusterIP                                                                                                                                                                                                                                             |
| service.port                 | the port of the service                                                    | N        | 9000                                                                                                                                                                                                                                                  |
| service.targetPort           | the pod port that the service will forward communiocation into             | N        | 9000                                                                                                                                                                                                                                                  |
| resources.limits.cpu         | limit pod cpu usage                                                        | N        | 100m                                                                                                                                                                                                                                                  |
| resources.limits.memory      | limit pod memory usage                                                     | N        | 128Mi                                                                                                                                                                                                                                                 |
| resources.requests.cpu       | required pod cpu in order to run                                           | N        | 10m                                                                                                                                                                                                                                                   |
| resources.requests.memory    | required pod cpu in order to run                                           | N        | 128Mi                                                                                                                                                                                                                                                 |

**Install:**
```shell
helm install fsi-common-helm/kafdrop $RELEASE_NAME
```
**NOTE: ** in order to set values without modifiyng the [values][31] file, you can use the following example for each parmeter you need to change
```shell
helm install fsi-common-helm/kafdrop $RELEASE_NAME --set kafka.truststoreSecret=my_truststore_secret
```
## Useful links

- [Using AMQ Streams on OpenShift][20]
- [Red Hat AMQ][21]
- [Red Hat Integration][22]
- [What is a service registry blog post][23]
- [Installing the Red Hat Integration operator on OpenShift guide][17]
- [Installing and deploying Service Registry on OpenShift guide][18]
- [Service Registry user guide][19]


<!-- links -->
[10]: https://www.redhat.com/en/technologies/cloud-computing/openshift/openshift-service-registry
[11]: https://www.redhat.com/en/products/integration
[12]: https://www.redhat.com/en/technologies/cloud-computing/openshift
[13]: https://www.redhat.com/en/technologies/jboss-middleware/amq
[14]: https://www.redhat.com/en/resources/amq-streams-datasheet
[15]: https://quay.io/repository/ecosystem-appeng/schema-pusher
[16]: https://avro.apache.org/
[17]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/installing_the_red_hat_integration_operator_on_openshift/index
[18]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/installing_and_deploying_service_registry_on_openshift/index
[19]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/service_registry_user_guide/index
[20]: https://access.redhat.com/documentation/en-us/red_hat_amq/2021.q3/html/using_amq_streams_on_openshift/index
[21]: https://access.redhat.com/products/red-hat-amq/
[22]: https://access.redhat.com/products/red-hat-integration
[23]: https://www.redhat.com/en/topics/integration/what-is-a-service-registry
[30]: https://github.com/obsidiandynamics/kafdrop
[31]: https://github.com/RHEcosystemAppEng/fsi-common-helm/blob/main/kafdrop/values.yaml
