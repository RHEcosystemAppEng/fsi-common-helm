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
Simply create a *tar.gz* archive with all of your schema files (subfolders are ok),</br>
install this *Chart*, and get back to work.</br>
:grin:

## Chart operation

This *Helm Chart* creates two resources for pushing schema files to [Red Hat's Service Registry][10]:

- A [ConfigMap](templates/configmap.yaml) for storing the configuration values for the operation.
- A [Pod](templates/pod.yaml) for publishing the schemas using the [schema-pusher][15] image.

Both resources named after the release suffixed with a *-configmap* and *-pod* respectively.

The *ConfigMap* stores the configuration for the execution,</br>
as well as a base64 encoded value representing the *tar.gz* archive containing schema files.</br>
The *Pod* decodes the encoded value, extracts the *tar.gz* archive,</br>
and produces the schema files recursively as messages per topic specified.

## Prerequisites

- A *tar.gz* archive containing the desired schema files for pushing.

## Configuration Values

Update [values.xml](values.xml) or use *Helm*s CLI to set the following configuration parameters:

| Parameter          | Description                                                       | Required | Example                                                         |
| ------------------ | ----------------------------------------------------------------- | :------: | --------------------------------------------------------------- |
| `kafka.bootstrap`  | kafka's bootstrap service url                                     | Y        | `http://<bootstrap-service>.<namespace>.svc.cluster.local:9092` |
| `service.registry` | redhat's service registry service url                             | Y        | `http://<registry-service>.<namespace>.svc.cluster.local:8080`  |
| `naming.strategy`  | subject naming strategy (topic, record, topic_record)             | Y        | `topic_record`                                                  |
| `topics`           | a list of one or more topics to produce the message to            | Y        | `[sometopic]`                                                   |
| `encoded.archive`  | a base64 encoded value for a tar.gz archive containg schema files | Y        | `$(base64 -w 0 schema_files.tar.gz)`                            |
| `labels`           | optional key-value pairs used as labels for the resources         | N        | `labelKey: labelValue`                                          |

> Note, when producing messages to multiple topics, only the *topic_record* strategy is allowed.

## Supported schema types

At the time of writing this, this application supports [Apache AVRO][16].</br>
Supported file types are `JSON`, `AVSC`, `AVRO`, other types won't get picked up by the application.

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
