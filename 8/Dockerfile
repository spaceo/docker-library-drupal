# from https://www.drupal.org/requirements/php#drupalversions
FROM php:7.1-apache

ENV workdir /var/www/html

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev libxml2-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip soap opcache bcmath

RUN apt-get -y install vim php7-xdebug php7-dev php-pear bzip2 git php-apc php7-memcache \
  memcached curl imagemagick php7-imagick mysql-client rsyslog net-tools php7-common graphviz

RUN echo 'local0.* /var/log/drupal.log' >> /etc/rsyslog.conf

WORKDIR ${workdir}

# Drush
RUN mkdir /root/.drush
ADD ./conf/drushrc.php /root/.drush/drushrc.php
# http://whaaat.com/installing-drush-8-using-composer
# Add drupal console.
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
RUN curl https://drupalconsole.com/installer -L -o drupal.phar && \
    php drupal.phar && \
    mv drupal.phar /usr/local/bin/drupal && \
    chmod +x /usr/local/bin/drupal && \
    /usr/local/bin/drupal check && \
    echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /root/.bashrc && \
    export PATH="$HOME/.composer/vendor/bin:$PATH"
RUN composer global require drush/drush:8.1.15
# Currently there is no drush_situs module for drush-8
# RUN /root/.composer/vendor/bin/drush dl drush_situs
# RUN composer global require drupal/console:1.0.0-beta5
# Initialise drupal/console
# RUN /var/www/html drupal init

# Adding php.ini conf.
ADD ./conf/php.ini /usr/local/etc/php/php.ini
ADD ./conf/php.cli.ini /etc/php7/cli/php.ini
RUN echo 'export PHPRC=/etc/php7/cli/php.ini' >> /root/.bashrc

# Adding xdebug conf and startup script.
ADD conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
ADD start.sh /start.sh
RUN (chmod 750 /start.sh)
