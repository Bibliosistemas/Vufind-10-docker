# Generated by Cloud66 Starter
FROM ubuntu:jammy
#install all the dependencies
RUN apt-get update 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y curl apache2 \
          libapache2-mod-php \
          php-pear \
          php \
          php-curl \
          php-dev \
          php-gd \
          php-intl \
          php-json \
          php-ldap \
          php-mbstring \
          php-pgsql \
          php-soap \
          php-xml \
          php-zip \
          pkg-config \
          apt-utils

##optional 1 set timezone
ENV TZ=America/Argentina/Mendoza
#optional 2 install of yaz lib for access z3950 servers 
RUN apt-get install -y libyaz4-dev 
RUN yes "" |pecl install yaz    
RUN ln -s /usr/include/x86_64-linux-gnu/curl/ /usr/local/include/curl
# optional solr library for SIG 
RUN apt-get install -y libcurl4-gnutls-dev 
RUN yes "" |pecl install solr

# configure apache
EXPOSE 80
EXPOSE 443
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY apache2-foreground /usr/bin/
RUN chmod +x /usr/bin/apache2-foreground 
RUN a2enmod rewrite
CMD ["apache2-foreground"]
