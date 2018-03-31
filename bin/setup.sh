#!/bin/bash

PEPIS_CMS_DATABASE_CONFIG_TYPE=native
PEPIS_CMS_DATABASE_HOSTNAME=db
PEPIS_CMS_DATABASE_USERNAME=pepiscms
PEPIS_CMS_DATABASE_PASSWORD=pepiscms
PEPIS_CMS_DATABASE_DATABASE=pepiscms
PEPIS_CMS_AUTH_DRIVER=native
PEPIS_CMS_AUTH_EMAIL=piotr@polak.ro
PEPIS_CMS_AUTH_PASSWORD=demodemo
PEPIS_CMS_SITE_EMAIL=piotr@polak.ro
PEPIS_CMS_SITE_NAME=Demonstration

composer install --prefer-dist && \
    cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_index.php ./index.php && \
    sed -i -e 's/TEMPLATE_VENDOR_PATH/\.\/vendor\//g' ./index.php && \
    cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_.htaccess ./.htaccess && \
    php index.php tools install && \
    php index.php tools register_admin $PEPIS_CMS_AUTH_EMAIL $PEPIS_CMS_AUTH_PASSWORD