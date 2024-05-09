#!/bin/bash
# fix /etc/hosts
if ! grep -q "localhost" /etc/hosts; then
	touch /etc/hosts
	chmod  644 /etc/hosts
	echo $HOSTNAME  localhost >> /etc/hosts
	echo "127.0.0.1 localhost" >> /etc/hosts
fi
#  check pub key
if [ -z ${pub_key+x} ]; then

        echo pub_key does not set in env variables
else

        [[ -d /root/.ssh ]] || mkdir -p /root/.ssh

				if ! grep -q "$pub_key" /root/.ssh/authorized_keys; then
					echo $pub_key >> /root/.ssh/authorized_keys
				fi
fi

chmod +x /opt/bin/*
echo "runing mariadb"
/bin/bash /opt/bin/mariadb_entry.sh
# prepare mysql server
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /var/log/mysql
chmod 777 /var/run/mysqld
echo "mariaserver running"
echo "running faveo server"
chown -R www-data:www-data /var/run/php

# prepare for ssh service
chmod 400 -R /etc/ssh/
mkdir -p /run/sshd
[ -d /root/.ssh/ ] || mkdir /root/.ssh

# prepare for supervisor service

[ -d /var/log/php-fpm ] || mkdir -p /var/log/php-fpm

chown -R www-data:www-data /var/log/supervisor

chgrp -R www-data /usr/share/nginx/storage /usr/share/nginx/bootstrap/cache
chmod -R ug+rwx . /usr/share/nginx/storage /usr/share/nginx/bootstrap/cache
chmod -R 0777 /usr/share/nginx/storage

chmod 0644 /etc/cron.d/faveo-cron

# use supervisord to start ssh, mysql and nginx and php-fpm

supervisord -c /etc/supervisor/supervisord.conf

exec "$@"
