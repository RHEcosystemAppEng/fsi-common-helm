{{/*
Create the auth-proxy args
*/}}
{{- define "auth-proxy.args" -}}
{{- if and .Values.auth.useSar .Values.auth.useEmailDomain }}
                                - --https-address=:8443
                                - --provider=openshift
                                - --openshift-service-account={{ .Release.Name }}-proxy
                                - --upstream={{ .Values.auth.upstream }}
                                - --tls-cert=/etc/tls/private/tls.crt
                                - --tls-key=/etc/tls/private/tls.key
                                - --cookie-secret={{ .Values.auth.cookieSecretName }}
                                - --cookie-refresh={{ .Values.auth.cookieRefreshSec }}s
                                - --openshift-sar={"namespace":"{{ .Values.auth.resource.namespae }}","resource":"{{ .Values.auth.resource.kind }}","name":"{{ .Values.auth.resource.name }}","verb":"{{ .Values.auth.resource.verb }}"}
                                - --email-domain={{ .Values.auth.emailDomain }}
{{- else if .Values.auth.useSar }}
                                - --https-address=:8443
                                - --provider=openshift
                                - --openshift-service-account={{ .Release.Name }}-proxy
                                - --upstream={{ .Values.auth.upstream }}
                                - --tls-cert=/etc/tls/private/tls.crt
                                - --tls-key=/etc/tls/private/tls.key
                                - --cookie-secret={{ .Values.auth.cookieSecretName }}
                                - --cookie-refresh={{ .Values.auth.cookieRefreshSec }}s
                                - --openshift-sar={"namespace":"{{ .Values.auth.resource.namespae }}","resource":"{{ .Values.auth.resource.kind }}","name":"{{ .Values.auth.resource.name }}","verb":"{{ .Values.auth.resource.verb }}"}
{{- else }}
                                - --https-address=:8443
                                - --provider=openshift
                                - --openshift-service-account={{ .Release.Name }}-proxy
                                - --upstream={{ .Values.auth.upstream }}
                                - --tls-cert=/etc/tls/private/tls.crt
                                - --tls-key=/etc/tls/private/tls.key
                                - --cookie-secret={{ .Values.auth.cookieSecretName }}
                                - --cookie-refresh={{ .Values.auth.cookieRefreshSec }}s
                                - --email-domain={{ .Values.auth.emailDomain }}
{{- end }}
{{- end }}