#!/bin/sh
VOLUME_HOME="/var/lib/mysql"
echo "=> starting up!"
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing MariaDB ..."
    mysql_install_db --user=mysql

    /usr/bin/mysqld_safe &
    sleep 10s

    echo "GRANT ALL ON *.* TO ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION;GRANT ALL ON *.* TO ${MYSQL_USER}@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -u root --password=""

    killall mysqld
    killall mysqld_safe
    sleep 10s
    killall -9 mysqld
    killall -9 mysqld_safe

    echo "=> Done!"

else
    echo "=> Using an existing volume"
fi

mysqld_safe --user=mysql
