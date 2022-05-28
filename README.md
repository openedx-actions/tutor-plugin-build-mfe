<img src="https://avatars.githubusercontent.com/u/40179672" width="75">

[![hack.d Lawrence McDaniel](https://img.shields.io/badge/hack.d-Lawrence%20McDaniel-orange.svg)](https://lawrencemcdaniel.com)
[![discuss.overhang.io](https://img.shields.io/static/v1?logo=discourse&label=Forums&style=flat-square&color=ff0080&message=discuss.overhang.io)](https://discuss.overhang.io)
[![docs.tutor.overhang.io](https://img.shields.io/static/v1?logo=readthedocs&label=Documentation&style=flat-square&color=blue&message=docs.tutor.overhang.io)](https://docs.tutor.overhang.io)

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)

# tutor-plugin-build-backup

Github Action to build a Docker image of the Tutor plugin "Backup & Restore", and upload to an AWS Elastic Container Registry repository.

## About this plugin

The "Backup & Restore" plugin is authored by hastexo: [https://github.com/hastexo/tutor-contrib-backup](https://github.com/hastexo/tutor-contrib-backup).

This is an experimental plugin for Tutor that provides backup and restore functionality for MySQL, MongoDB, and Caddy services in both local and Kubernetes Tutor deployments.

In Kubernetes, the plugin runs the backup job as a CronJob by default. You can also run the backup job from the command line. In both cases the backup tar file is stored in an S3 bucket. Then, in a new Kubernetes deployment, you can use the restore command to restore your Open edX environment. You can even schedule the restore as a CronJob to periodically download the latest backup and restore your environment. This can, for example, be useful if you want to maintain a standby site for disaster recovery purposes.

## Usage:


```yaml
name: Example workflow

on: workflow_dispatch

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # required antecedent
      - uses: actions/checkout@v1

      # required antecedent
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.THE_NAME_OF_YOUR_AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.THE_NAME_OF_YOUR_AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-2

      # This action.
      # Note that both inputs are optional.
      #  - aws-ecr-repo: default value is openedx_backup
      #  - hastexo-backup-release: default is latest stable
      - name: Build the image and upload to AWS ECR
        uses: openedx-actions/tutor-plugin-build-backup
        with:
          aws-ecr-repo: openedx_backup
          hastexo-backup-release: 'v0.0.6'
```
