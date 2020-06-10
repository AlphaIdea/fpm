FROM php:7.3-fpm-stretch

RUN apt-get update \
&& apt-get install -y git zip unzip libssl-dev libcurl4-openssl-dev pkg-config build-essential zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev \
&& pecl install mongodb \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-enable mongodb \
&& docker-php-ext-install gd mysqli pdo_mysql \
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" \
&& mv ./composer.phar /usr/local/bin/composer
