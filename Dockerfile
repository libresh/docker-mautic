FROM php:5.6-apache
#update repo

RUN apt-get update && apt-get install -y \
        libc-client-dev \
        libicu-dev \
        libkrb5-dev \
        libmcrypt-dev \
        libssl-dev \
        zip \
        curl \
        git \
       unzip 

#Download dependencies

# Set memory limit
RUN echo "memory_limit=1024M" > /usr/local/etc/php/conf.d/memory-limit.ini

# Set environmental variables
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# RUN a2enmod rewrite

RUN docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos

RUN docker-php-ext-install \
   imap \
    intl \
    iconv \
    mcrypt \
    mcrypt \
    mbstring \
    mysql  \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_mysql

#VOLUME /var/www/html


# Define Mautic version and expected SHA1 signature
ENV MAUTIC_VERSION 1.2.4
ENV MAUTIC_SHA1 f0f89343f9ce67b6b4cafb44fd7b15f325ed726f

# Download package and extract to web volume
RUN curl -o mautic.zip -SL https://s3.amazonaws.com/mautic/releases/${MAUTIC_VERSION}.zip \
	&& echo "$MAUTIC_SHA1 *mautic.zip" | sha1sum -c - \
	&& unzip mautic.zip -d /var/www/html \
	&& rm mautic.zip \
	&& chown -R www-data:www-data /var/www/html
