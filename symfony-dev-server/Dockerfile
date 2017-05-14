FROM alpine

MAINTAINER Zach. D. Lamazière <z@z4c.fr>

# php basic stuff
RUN apk add --update \
	php5-apcu \
	php5-ctype \
	php5-curl \
	php5-dom \
	php5-gd \
	php5-iconv \
	php5-imagick \
	php5-json \
	php5-intl \
	php5-mcrypt \
	php5-mysql \
	php5-opcache \
	php5-openssl \
	php5-pdo \
	php5-pdo_mysql \
	php5-phar \
	php5-pdo_pgsql \
	php5-pgsql \
	php5-mysqli \
	php5-xml \
	php5-zlib

# smooth dev tools
RUN apk add --update bash \
	git \
	openssh-client \
	curl \
	figlet \
#	vim

# composer installation
RUN curl -sS https://getcomposer.org/installer | \
	php -- --install-dir=/usr/local/bin --filename=composer

# extra php configs
ADD symfony.ini /etc/php5/fpm/conf.d/
ADD symfony.ini /etc/php5/cli/conf.d/

COPY docker-entrypoint /

WORKDIR /source
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 80
