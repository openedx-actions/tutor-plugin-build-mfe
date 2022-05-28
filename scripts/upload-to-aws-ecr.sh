#!/bin/bash
#---------------------------------------------------------
#
# Push and tag the newly created Docker image.
#
#---------------------------------------------------------
tutor images push mfe
docker tag ${AWS_ECR_REGISTRY}/${AWS_ECR_REPOSITORY}:${REPOSITORY_TAG} ${AWS_ECR_REGISTRY}/${AWS_ECR_REPOSITORY}:latest
docker push ${AWS_ECR_REGISTRY}/${AWS_ECR_REPOSITORY}:latest
