{{/*
Expand the name of the chart.
*/}}
{{- define "as-vdb-grpc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "as-vdb-grpc.fullname" -}}
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
{{- define "as-vdb-grpc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "as-vdb-grpc.labels" -}}
helm.sh/chart: {{ include "as-vdb-grpc.chart" . }}
{{ include "as-vdb-grpc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "as-vdb-grpc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "as-vdb-grpc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "as-vdb-grpc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "as-vdb-grpc.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Image repository helper
*/}}
{{- define "as-vdb-grpc.imageRepository" -}}
{{- $root := .root -}}
{{- $image := .image -}}
{{- if $root.Values.global.imageRegistry }}
{{- printf "%s/%s" $root.Values.global.imageRegistry $image.repository }}
{{- else }}
{{- $image.repository }}
{{- end }}
{{- end }}

{{/*
Image tag helper
*/}}
{{- define "as-vdb-grpc.imageTag" -}}
{{- if .tag }}
{{- .tag }}
{{- else if .defaultTag }}
{{- .defaultTag }}
{{- else }}
{{- "latest" }}
{{- end }}
{{- end }}

{{/*
Namespace helper
*/}}
{{- define "as-vdb-grpc.namespace" -}}
{{- default .Release.Namespace .Values.global.namespace }}
{{- end }}