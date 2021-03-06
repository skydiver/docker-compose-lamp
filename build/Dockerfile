FROM php:7.1-apache

# ENABLE MOD REWRITE
RUN a2enmod rewrite

# INSTALL PACKAGES
RUN apt update \
	&& apt install -y git-core libsqlite3-dev libpq-dev libmcrypt-dev libpng12-dev libjpeg-dev libicu-dev libxslt1.1 libxslt1-dev libfreetype6-dev \
	&& rm -rf /var/lib/apt/lists/*

# CONFIGURE PHP EXTENSIONS
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr --with-freetype-dir=/usr \
        && docker-php-ext-configure intl

# ENABLE PHP EXTENSIONS
RUN docker-php-ext-install gd mysqli mcrypt zip mbstring pdo pdo_mysql pdo_sqlite pdo_pgsql json intl xsl soap

# PHP OPCACHE
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

# INSTALL COMPOSER + PACKAGES
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require "hirak/prestissimo:^0.3"

# DOCKER
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
