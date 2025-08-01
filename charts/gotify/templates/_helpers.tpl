{{/*
Expand the name of the chart.
*/}}
{{- define "gotify.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gotify.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gotify.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gotify.labels" -}}
helm.sh/chart: {{ include "gotify.chart" . }}
{{ include "gotify.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gotify.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gotify.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "gotify.resticForgetCommand" -}}
restic forget --prune --group-by path
{{- $validKeys := list "last" "hourly" "daily" "weekly" "monthly" "yearly" "within" "within-hourly" "within-daily" "within-weekly" "within-monthly" "within-yearly" -}}
{{- with .Values.backup.keep -}}
{{- range $key, $value := . -}}
{{- $kebabKey := kebabcase $key }}
{{- if (not (has $kebabKey $validKeys)) -}}
{{- fail "backup.keep key must be a valid Restic forget option." }}
{{- end }} --keep-{{ $kebabKey }} {{ $value }}
{{- end -}}
{{- end -}}
{{- end }}