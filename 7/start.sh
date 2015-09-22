#!/bin/bash
  
#make sure xdebug remote host is set
# remove xdebug.remote_host line from xdebug.ini
sed -i '/xdebug.remote_host/d' /usr/local/etc/php/conf.d/xdebug.ini

# gateway == remote host for debugging
gateway=`route |grep default |awk '{print $2}'`

(
cat << EOF1
xdebug.remote_host = $gateway
EOF1
) >> /etc/php5/mods-available/xdebug.ini

# Start syslog
service rsyslog start