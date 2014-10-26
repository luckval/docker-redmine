#!/bin/sh

TOPDIR=$(cd `dirname $0`; pwd)/..
USER=luck

MYSQL_CONTAINER=`docker ps -a | awk '/mysql\s+$/ {print $1;}'`
if [ "$MYSQL_CONTAINER" = "" ]; then
    #docker run --name mysql -d -v ${TOPDIR}/data/mysql:/var/lib/mysql -p 3306:3306 ${USER}/mysql
    docker run --name mysql -d -v /var/lib/mysql ${USER}/mysql
    sleep 5
fi

REDMINE_CONTAINER=`docker ps -a | awk '/redmine\s+$ {print $1;}'`
if [ "$REDMINE_CONTAINER" != "" ]; then
    docker rm redmine
fi

if [ "$1" = "" ]; then
    docker run --name redmine -it --rm -v ${TOPDIR}/data/redmine:/redmine --volumes-from mysql ${USER}/redmine /assets/setup.sh
else
    docker run --name redmine -it --rm -v ${TOPDIR}/data/redmine:/redmine --volumes-from mysql ${USER}/redmine $*
fi

