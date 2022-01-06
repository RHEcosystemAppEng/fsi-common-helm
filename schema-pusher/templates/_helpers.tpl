
{{/*
Labels for use with both the Pod and the ConfigMap
*/}}
{{- define "resource.labels" -}}
app.kubernetes.io/name: schema-pusher
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- range $key, $val := $.Values.labels }}
{{ $key }}: {{ $val | quote }}
{{- end }}
{{- end }}
