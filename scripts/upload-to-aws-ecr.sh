#!/bin/bash
#---------------------------------------------------------
#
# Push and tag the newly created Docker image.
#
#---------------------------------------------------------
tutor images push mfe
docker tag ${AWS_ECR_REGISTRY_MFE}/${AWS_ECR_REPOSITORY_MFE}:${REPOSITORY_TAG_MFE} ${AWS_ECR_REGISTRY_MFE}/${AWS_ECR_REPOSITORY_MFE}:latest
docker push ${AWS_ECR_REGISTRY_MFE}/${AWS_ECR_REPOSITORY_MFE}:latest
