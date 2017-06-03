FROM php:7.0-fpm

MAINTAINER Dan Braghis <dan@zerolab.org>

# Install additional packages for MySQL/Drupal.
RUN apt-get update -y \
    && apt-get -y install git curl unzip mariadb-client-10.0 net-tools \
       libjpeg62-turbo-dev libpng12-dev libpq-dev \
       libcurl4-openssl-dev libfreetype6-dev libxslt1-dev libxml2-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install dom gd hash json mbstring pdo_mysql zip xml

# Cleanup
RUN DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tweak config
RUN echo 'memory_limit="256M"' > /usr/local/etc/php/conf.d/memory_limit.ini
RUN echo "date.timezone = Europe/London" > /usr/local/etc/php/conf.d/test.ini

# Composer
RUN curl -L https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN export PATH="$HOME/.composer/vendor/bin:$PATH"
RUN composer global require "hirak/prestissimo:^0.3"

EXPOSE 9000

CMD ["php-fpm"]
