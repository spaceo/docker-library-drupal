# from https://www.drupal.org/requirements/php#drupalversions
FROM php:5.6-apache

RUN a2enmod rewrite
RUN a2enmod headers

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev libxml2-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip soap

RUN apt-get -y install vim php5-xdebug php5-dev php-pear bzip2 git php-apc php5-memcache \
  memcached curl imagemagick php5-imagick mysql-client rsyslog net-tools php5-common graphviz

RUN echo 'local0.* /var/log/drupal.log' >> /etc/rsyslog.conf

WORKDIR /var/www/html

# Xhprof
ADD ./conf/xhprof.ini /usr/local/etc/php/conf.d/xhprof.ini
RUN pecl install xhprof-0.9.4
RUN php5enmod xhprof
RUN mkdir /tmp/xhprof
RUN chmod 777 /tmp/xhprof
RUN chown www-data.www-data /tmp/xhprof
RUN chown www-data.www-data /usr/local/lib/php/xhprof_html

# Drush
RUN mkdir /root/.drush
ADD ./conf/drushrc.php /root/.drush/drushrc.php
# http://whaaat.com/installing-drush-8-using-composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> /root/.bashrc
RUN export PATH="$HOME/.composer/vendor/bin:$PATH"
RUN composer global require drush/drush:8.0.0-beta14
RUN /root/.composer/vendor/bin/drush dl drush_situs

# Adding php.ini conf.
ADD ./conf/php.ini /usr/local/etc/php/php.ini
ADD ./conf/php.cli.ini /etc/php5/cli/php.ini
RUN echo 'export PHPRC=/etc/php5/cli/php.ini' >> /root/.bashrc

# Adding xdebug conf
ADD conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Virtual hosts
ADD conf/apache/aktivdb.dev.conf /etc/apache2/sites-available/aktivdb.dev.conf
ADD conf/apache/ws.aktivdb.dev.conf /etc/apache2/sites-available/ws.aktivdb.dev.conf
RUN a2ensite aktivdb.dev
RUN a2ensite ws.aktivdb.dev

# Using aktivdb as main acces for drush cmds
RUN cd /var/www && rm -rf html && ln -s aktivdb.dev/htdocs html

# Adding startup script
ADD start.sh /start.sh
RUN (chmod 750 /start.sh)
