#!/bin/bash
  
#make sure xdebug remote host is set
# remove xdebug.remote_host line from xdebug.ini
#sed -i '/xdebug.remote_host/d' /usr/local/etc/php/conf.d/xdebug.ini

# gateway == remote host for debugging
#gateway=`route |grep default |awk '{print $2}'`

#(
#cat << EOF1
#xdebug.remote_host = $gateway
#EOF1
#) >> /usr/local/etc/php/conf.d/xdebug.ini

# Reload exim4
#/etc/init.d/exim4 reload

# Reload nullmailer
/etc/init.d/nullmailer reload

# Reload apache2 to adjust to xdebug settings.
service apache2 reload

# Start syslog
service rsyslog start
