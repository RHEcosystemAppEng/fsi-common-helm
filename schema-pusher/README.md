# Schema pusher chart

## Chart description

This *Helm Chart* creates two resources for pushing schema files to Red Hat's Service Registry:

- A [ConfigMap](templates/configmap.yaml) for storing the configuration for the operation.
- A [Pod](templates/pod.yaml) containg one container performing a one-time-execution of the [schema-pusher][0] image.

The *ConfigMap* stores the configuration for the execution as well as a base64 encoded value representing a **tar.gz**
archive containing schema files for pushing to the registry.</br>
The *Pod* decodes the encoded value, extracts the *tar.gz* archive, and produces the schema files as messages per topic
specified.

## Prerequisites

- A *tar.gz* archive containing the desired schema files for pushing.

## Configuration Values

Update [values.xml](values.xml) or use *Helm*s cli to set the following configuration parameters:

| Parameter          | Description                                                       | Required | Example                                                         |
| ------------------ | ----------------------------------------------------------------- | :------: | --------------------------------------------------------------- |
| `kafka.bootstrap`  | kafka's bootstrap service url                                     | Y        | `http://<bootstrap-service>.<namespace>.svc.cluster.local:9092` |
| `service.registry` | redhat's service registry service url                             | Y        | `http://<registry-service>.<namespace>.svc.cluster.local:9092`  |
| `naming.strategy`  | subject naming strategy (topic, record, topic_record)             | Y        | `topic_record`                                                  |
| `topics`           | a list of one or more topics to produce the message to            | Y        | `[sometopic]`                                                   |
| `encoded.archive`  | a base64 encoded value for a tar.gz archive containg schema files | Y        | `$(base64 -w 0 schema_files.tar.gz)`                            |
| `labels`           | an optional list of strings represnting label for the resources   | N        | `["app: schema-pusher-app"]`                                    |

**Important notes**:

- When producing messages to multiple topics, only the *topic_record* strategy is allowed.
- Schema files of type `JSON`, `AVSC`, `AVRO` are supported, other files won't get picked up by the application.
- The files extracted from the decoded *tar.gz* archive, will be scanned recursively.

## Links

- [The schema-pusher docker image][0]
- [What is a service registry blog post][1]
- [Installing the red hat integration operator on openshift guide][2]
- [Installing and deploying service registry on openshift guide][3]
- [Service registry user guide][4]
- [Using AMQ Streams on openshift][5]
- [Red Hat AMQ][6]
- [Apache AVRO][7]

<!-- links -->
[0]: https://quay.io/repository/ecosystem-appeng/schema-pusher
[1]: https://www.redhat.com/en/topics/integration/what-is-a-service-registry
[2]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/installing_the_red_hat_integration_operator_on_openshift/index
[3]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/installing_and_deploying_service_registry_on_openshift/index
[4]: https://access.redhat.com/documentation/en-us/red_hat_integration/2021.q3/html/service_registry_user_guide/index
[5]: https://access.redhat.com/documentation/en-us/red_hat_amq/2021.q3/html/using_amq_streams_on_openshift/index
[6]: https://access.redhat.com/products/red-hat-amq/
[7]: https://avro.apache.org/
