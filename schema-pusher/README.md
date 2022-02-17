# Schema pusher chart

<!-- markdownlint-disable -->
<a href="https://www.redhat.com/en">
    <img src="https://raw.githubusercontent.com/RHEcosystemAppEng/fsi-common-helm/main/schema-pusher/images/schema_pusher_helm_chart_flow.png" width="800" height="350" alt="">
</a>
<!-- markdownlint-restore -->

[Red Hat's Service Registry][10], part of [Red Hat's Integration][11] services portfolio,</br>
is a *Kafka* based schema database.</br>
Used for sharing and reusing data structures between developers and services.</br>
An ideal solution for a complex microservices-based environment.</br>

And if you're in for the *full* [OpenShift][12] experience,</br>
[AMQ][13] which is also part of [Red Hat's Integration][11] services portfolio,</br>
got your underlying *Kafka* deployment covered with [AMQ Streams][14].

This *Helm Chart* helps you easily migrate your various data structures, schemas to [Red Hat's Service Registry][10].</br>
Simply install this *Chart* specifying a list of topics and schemas, and get back to work.</br>
:grin:

## Installation

Adding the repo:

```shell
helm repo add fsi-common-helm https://rhecosystemappeng.github.io/fsi-common-helm/
```

Applying the chart:

```shell
helm upgrade fsi-common-helm/schema-pusher --generate-name \
--set kafka.bootstrap=https://<kafka-bootstrap-url-goes-here>:443 \
--set kafka.certificates.server.secret=kafka-cluster-ca-cert \
--set kafka.certificates.user.secret=kafka-user-cert \
--set service.registry=http://<service-registry-goes-here> \
--set naming.strategy=topic_record \
--set topics[0]=sometopic --set schemas[0]=$(base64 -w 0 my_schema.avsc) \
--set topics[1]=someothertopic --set schemas[1]=$(base64 -w 0 my_other_schema.avsc)
```

> Note the correlation between the *topics* and *schemas*.

## Chart operation

This *Helm Chart* creates two resources for pushing schema files to [Red Hat's Service Registry][10]:

- A [ConfigMap](templates/configmap.yaml) for storing the configuration values for the operation.
- A [Pod](templates/pod.yaml) for publishing the schemas using the [schema-pusher][15] image.

Both resources named after the release suffixed with a *-configmap* and *-pod* respectively.

## Configuration Values

Update [values.yaml](values.yaml) or use *helm* to set the following configuration parameters:

| Parameter                          | Description                                                            | Required | Example                                       |
| ---------------------------------- | ---------------------------------------------------------------------- | :------: | --------------------------------------------- |
| `kafka.bootstrap`                  | kafka's bootstrap service url                                          | Y        | `https://<kafka-bootstrap-url-goes-here>:443` |
| `kafka.certificates.server.secret` | secret name containing the *ca.p12* and *ca.password* data entries     | N        | `my-kafka-cluster-cluster-ca-cert`            |
| `kafka.certificates.user.secret`   | secret name containing the *user.p12* and *user.password* data entries | N        | `my-kafka-cluster-user-cert`                  |
| `service.registry`                 | redhat's service registry service url                                  | Y        | `http://<service-registry-url-goes-here>`     |
| `naming.strategy`                  | subject naming strategy (topic, record, topic_record)                  | Y        | `topic_record`                                |
| `topics`                           | a list of one or more topics to produce the message to                 | Y        | `[sometopic]`                                 |
| `schemas`                          | a base64 encoded value for schema files                                | Y        | `[$(base64 -w 0 /path/to/my_schema.json)]`    |
| `labels`                           | optional key-value pairs used as labels for the resources              | N        | `labelKey: labelValue`                        |

> Please keep the *topics* and *schemas* correlated.

## Schema types

Currently, we support [AVRO Schemas][16].

## Useful links

- [What is a service registry blog post][23]
- [The schema-pusher Docker image][15]
- [Installing the Red Hat Integration operator on OpenShift guide][17]
- [Installing and deploying Service Registry on OpenShift guide][18]
- [Service Registry user guide][19]
- [Using AMQ Streams on OpenShift][20]
- [Red Hat AMQ][21]
- [Red Hat Integration][22]

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
