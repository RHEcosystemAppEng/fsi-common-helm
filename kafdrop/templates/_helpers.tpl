{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "chart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

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
                                - --openshift-sar={"namespace":"{{ .Values.auth.resource.namespace }}","resource":"{{ .Values.auth.resource.kind }}","name":"{{ .Values.auth.resource.name }}","verb":"{{ .Values.auth.resource.verb }}"}
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
                                - --openshift-sar={"namespace":"{{ .Values.auth.resource.namespace }}","resource":"{{ .Values.auth.resource.kind }}","name":"{{ .Values.auth.resource.name }}","verb":"{{ .Values.auth.resource.verb }}"}
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
