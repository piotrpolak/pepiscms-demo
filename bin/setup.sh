#!/bin/bash

# Database configuration is overwritten by Heroku
#PEPIS_CMS_DATABASE_HOSTNAME=db
#PEPIS_CMS_DATABASE_USERNAME=pepiscms
#PEPIS_CMS_DATABASE_PASSWORD=pepiscms
#PEPIS_CMS_DATABASE_DATABASE=pepiscms

PEPIS_CMS_DATABASE_CONFIG_TYPE=native
PEPIS_CMS_AUTH_DRIVER=native
PEPIS_CMS_AUTH_EMAIL=piotr@polak.ro
PEPIS_CMS_AUTH_PASSWORD=demodemo
PEPIS_CMS_SITE_EMAIL=piotr@polak.ro
PEPIS_CMS_SITE_NAME=Demonstration

composer update piotrpolak/pepiscms && \
    echo "PepisCMS updated"

cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_index.php ./index.php && \
    echo "index.php created" && \
    sed -i -e 's/TEMPLATE_VENDOR_PATH/\.\/vendor\//g' ./index.php && \
    echo "vendor path adjusted" && \
    cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_.htaccess ./.htaccess && \
    echo ".htaccess created" && \
    php index.php tools install true&& \
    echo "PepisCMS installed" && \
    php index.php tools register_admin $PEPIS_CMS_AUTH_EMAIL $PEPIS_CMS_AUTH_PASSWORD && \
    echo "Admin account created"

chmod 0777 -R application/cache/ application/config/ application/logs/ uploads/ && \
    echo "Access rights adjusted"