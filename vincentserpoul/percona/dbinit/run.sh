#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized PerconaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing PerconaDB ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
    /init_percona_db.sh
else
    echo "=> Using an existing volume of PerconaDB"
fi

exec mysqld_safe
