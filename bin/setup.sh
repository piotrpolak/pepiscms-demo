#!/bin/bash

# Database configuration is overwritten by Heroku
#export PEPIS_CMS_DATABASE_HOSTNAME=db
#export PEPIS_CMS_DATABASE_USERNAME=pepiscms
#export PEPIS_CMS_DATABASE_PASSWORD=pepiscms
#export PEPIS_CMS_DATABASE_DATABASE=pepiscms

export PEPIS_CMS_DATABASE_CONFIG_TYPE=native
export PEPIS_CMS_AUTH_DRIVER=native
export PEPIS_CMS_AUTH_EMAIL=demo@example.com
export PEPIS_CMS_AUTH_PASSWORD=demodemo
export PEPIS_CMS_SITE_EMAIL=noreply@example.com
export PEPIS_CMS_SITE_NAME=Demonstration

composer update piotrpolak/pepiscms && \
    echo "PepisCMS updated"

cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_index.php ./index.php && \
    echo "index.php created" && \
    sed -i -e 's/TEMPLATE_VENDOR_PATH/\.\/vendor\//g' ./index.php && \
    echo "vendor path adjusted" && \
    cp vendor/piotrpolak/pepiscms/pepiscms/resources/config_template/template_.htaccess ./.htaccess && \
    echo ".htaccess created" && \
    php index.php tools install true && \
    echo "PepisCMS installed" && \
    php index.php tools register_admin $PEPIS_CMS_AUTH_EMAIL $PEPIS_CMS_AUTH_PASSWORD && \
    echo "Admin account created"

DEPLOY_DATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "" >> application/config/_pepiscms.php && \
    echo "\$config['cms_login_page_description'] = '$PEPIS_CMS_AUTH_EMAIL / $PEPIS_CMS_AUTH_PASSWORD<br>Deployed at $DEPLOY_DATE';" >> application/config/_pepiscms.php && \
    echo "Customized login page"

chmod 0777 -R application/cache/ && \
    chmod 0777 -R application/config/ && \
    chmod 0777 -R application/logs/ && \
    chmod 0777 -R uploads/ && \
    echo "Access rights adjusted"