---
title: gotify
description: Gotify server.
---

#### Chart based on https://lkummer.github.io/Helm-Charts/gotify/

## What's new?

- v0.4.1
  - Refactored templates/deployment.yaml
  - Fixed values.yaml.

- v0.4.0
  - Added support for environment variables and environment variables from Kubernetes ConfigMap or Secret.
  - Added secret support.
  - Refactored configmap support.

- v0.3.0
  - Added ingressClassName support
  - Extracted TLS Secrets into a dedicated section
  - Added storageClassName support

## Prerequisites

Add the repository to Helm:

```shell
helm repo add izyakin-helm-charts https://raw.githubusercontent.com/Izyakin/Helm-Charts/main/
helm repo update
```


## Deploy the Chart

Create a `values.yaml` file with values you wish to override.

Install the chart:

```shell
helm install example izyakin-helm-charts/gotify --file values.yaml
```
## Upgrade the Chart

Upgrade the chart:

```shell
helm upgrade example izyakin-helm-charts/gotify --file values.yaml
```

## Delete the Chart

Delete the chart:

```shell
helm delete example
```

## Configuration

The chart offers the following list of configuration values.

| Parameter | Description
| - | - |
| `env` | Environment variables for the Gotify container. |
| `volumeClaim` | PersistentVolumeClaim related options. |
| `volumeClaim.enabled` | Enable PersistentVolumeClaim resource. |
| `volumeClaim.name` | Name of the PersistentVolumeClaim resource. |
| `volumeClaim.storageClassName` | Storage class name for the PersistentVolumeClaim. |
| `volumeClaim.annotations` | Kubernetes annotations for the PersistentVolumeClaim. |
| `volumeClaim.resources` | PersistentVolumeClaim resources options. |
| `volumeClaim.volumeMode` | PersistentVolumeClaim volumeMode option. |
| `volumeClaim.accessModes` | PersistentVolumeClaim accessModes option. |
| `volumeClaim.selector` | PersistentVolumeClaim selector option. |
| `ingress` | Ingress related options. |
| `ingress.enabled` | Enable ingress resource. |
| `ingress.annotations` | Kubernetes annotations for the ingress. |
| `ingress.hosts` | Ingress hosts configuration. |
| `ingress.ingressClassName` | Ingress class name. |
| `ingress.tls` | Ingress TLS configuration. |
| `ingress.tls.enabled` | Enable TLS for ingress when true. |
| `ingress.tls.secretName` | Secret name for TLS certificate. |
| `nameOverride` | Override the name of the chart. |
| `fullnameOverride` | Override the full name of the chart. |
| `imagePullSecrets` | Image pull secrets. |
| `image` |Gotify image related settings.|
| `image.repository` |Repository to pull Gotify image from.|
| `image.pullPolicy` |Pull policy for Gotify image.|
| `image.tag` |Gotify image tag override.|
| `resources` |Gotify container resource limits and requests.|
| `service` |Load balancer service related options.|
| `service.port` |Port to use for Gotify Service resource.|
| `podAnnotations` | Kubernetes annotations for the pod. |
| `podSecurityContext` | Security context of the pod. |
| `nodeSelector` | Pod node selector. |
| `tolerations` | Pod tolerations. |
| `affinity` | Pod affinity. |
| `backup` | Backup and restore related options. |
| `backup.enabled` | Enable backup and restore functionality when true. |
| `backup.backup.enabled` | Enable backup CronJob when true. |
| `backup.backup.schedule` | Backup CronJob schedule. |
| `backup.restore.enabled` | Enable backup restoration when true. |
| `backup.restore.snapshot` | Restic snapshot to restore from. |
| `backup.keep` | Keep options passed to Restic forget command, see values for an example. |
| `backup.repository.s3AccessKey` | S3 access key for backup storage authentication. |
| `backup.repository.s3SecretKey` | S3 secret key for backup storage authentication. |
| `backup.repository.repository` | Backup Restic repository, see values for an example. |
| `backup.repository.repositoryPassword` | Backup Restic repository password. |

## Example

Install Gotify and configure TLS.

```yaml
configuration:
  defaultUser:
    name: admin
    password: supersecret

ingress:
  enabled: true
  hosts: 
    - paths:
      - host: gotify.example.com
        path: /
        pathType: Prefix
  tls:
    - secretName: gotify-tls
      hosts:
        - gotify.example.com
```