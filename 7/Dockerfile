# from https://www.drupal.org/requirements/php#drupalversions
FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev libxml2-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip soap

RUN apt-get -y install vim php5-xdebug bzip2 git php-apc php5-memcache memcached curl imagemagick php5-imagick mysql-client rsyslog net-tools

RUN echo 'local0.* /var/log/drupal.log' >> /etc/rsyslog.conf

WORKDIR /var/www/html

# Drush
RUN mkdir /root/.drush
ADD ./conf/drushrc.php /root/.drush/drushrc.php
# http://whaaat.com/installing-drush-8-using-composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN  echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /root/.bashrc
RUN export PATH="$HOME/.composer/vendor/bin:$PATH"
RUN composer global require drush/drush:dev-master
RUN /root/.composer/vendor/bin/drush dl drush_situs

# Adding php.ini conf.
ADD ./conf/php.ini /usr/local/etc/php/php.ini

# Adding xdebug conf and startup script.
ADD conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
ADD start.sh /start.sh
RUN (chmod 750 /start.sh)
