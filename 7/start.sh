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

# Reload apache2 to adjust to xdebug settings.
service apache2 reload

# Start syslog
service rsyslog start
