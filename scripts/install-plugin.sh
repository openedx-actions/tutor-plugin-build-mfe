#!/bin/bash
#---------------------------------------------------------
#
# - Download and tutor-install the MFE plugin.
# - Set the URL of the Docker image so that we can push to a
#   public repository in a later step.
# - build the environment files
#
#---------------------------------------------------------


pip install tutor-mfe
tutor plugins enable mfe
tutor config save --set MFE_DOCKER_IMAGE=${AWS_ECR_REGISTRY}/${AWS_ECR_REPOSITORY}:${REPOSITORY_TAG}

# build the production environment file
cat <<EOT >> "$(tutor config printroot)/env/plugins/mfe/build/mfe/env/production"
ACCESS_TOKEN_COOKIE_NAME='edx-jwt-cookie-header-payload'
BASE_URL='https://apps.${SUBDOMAIN}.${DOMAIN_NAME}'
CSRF_TOKEN_API_PATH='/csrf/api/v1/token'
CREDENTIALS_BASE_URL='https://credentials.${SUBDOMAIN}.${DOMAIN_NAME}'
DISCOVERY_API_BASE_URL='https://discovery.${SUBDOMAIN}.${DOMAIN_NAME}'
ECOMMERCE_BASE_URL='https://ecommerce.${SUBDOMAIN}.${DOMAIN_NAME}'
ENABLE_NEW_RELIC='false'
FAVICON_URL='https://cdn.${SUBDOMAIN}.${DOMAIN_NAME}/favicon.ico'
LANGUAGE_PREFERENCE_COOKIE_NAME='openedx-language-preference'
LMS_BASE_URL='https://${SUBDOMAIN}.${DOMAIN_NAME}'
LOGIN_URL='https://${SUBDOMAIN}.${DOMAIN_NAME}/login'
LOGO_URL='https://cdn.${SUBDOMAIN}.${DOMAIN_NAME}/logo.png'
LOGO_TRADEMARK_URL='https://cdn.${SUBDOMAIN}.${DOMAIN_NAME}/logo.png'
LOGO_WHITE_URL='https://cdn.${SUBDOMAIN}.${DOMAIN_NAME}/logo.png'
LOGOUT_URL='https://${SUBDOMAIN}.${DOMAIN_NAME}/logout'
MARKETING_SITE_BASE_URL='https://${SUBDOMAIN}.${DOMAIN_NAME}'
NODE_ENV=production
PUBLISHER_BASE_URL=''
REFRESH_ACCESS_TOKEN_ENDPOINT='https://${SUBDOMAIN}.${DOMAIN_NAME}/login_refresh'
SEGMENT_KEY=''
SITE_NAME='${SITE_NAME}'
STUDIO_BASE_URL='https://studio.${SUBDOMAIN}.${DOMAIN_NAME}'
USER_INFO_COOKIE_NAME='user-info'
EOT

# build the development environment file
cat <<EOT >> "$(tutor config printroot)/env/plugins/mfe/build/mfe/env/development"
DISCOVERY_API_BASE_URL=''
LMS_BASE_URL='http://${SUBDOMAIN}:8000'
LOGIN_URL='http://${SUBDOMAIN}:8000/login'
LOGO_URL='http://${SUBDOMAIN}:8000/theming/asset/images/logo.png'
LOGO_TRADEMARK_URL='http://${SUBDOMAIN}:8000/theming/asset/images/logo.png'
LOGOUT_URL='http://${SUBDOMAIN}:8000/logout'
MARKETING_SITE_BASE_URL='http://${SUBDOMAIN}:8000'
NODE_ENV=development
REFRESH_ACCESS_TOKEN_ENDPOINT='http://${SUBDOMAIN}:8000/login_refresh'
STUDIO_BASE_URL='http://studio.${SUBDOMAIN}:8001'
EOT
