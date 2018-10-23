#!/bin/bash

if [ -z "$PHP_VERSION" ];
then
    PHP_VERSION=7.2
fi

docker run --rm -v `pwd`:/app -it "php:${PHP_VERSION}-cli" sh -c "apt-get update && apt-get install -yq git zip unzip libpng-dev && rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install gd && \
    docker-php-ext-install zip && \
    php -r \"copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');\" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    cd /app && \
    composer --prefer-dist install && \
    rm -rf vendor"