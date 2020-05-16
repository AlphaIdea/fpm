FROM php:fpm

RUN apt-get update \
&& apt-get install -y git zip unzip libssl-dev libcurl4-openssl-dev pkg-config supervisor \
&& pecl install mongodb \
&& docker-php-ext-enable mongodb \
&& docker-php-ext-install mysqli pdo_mysql \
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" \
&& mv ./composer.phar /usr/local/bin/composer

COPY ./supervisord.conf /etc/supervisor/

ENTRYPOINT /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
