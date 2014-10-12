#!/bin/sh 

USER=luck

MYSQL_CONTAINER=$(docker ps -a | grep /mysql$/)
if [ "$MYSQL_CONTAINER" != "" ]; then
    docker run -d --name mysql -v /var/lib/mysql luck/mysql
fi

REDMINE_CONTAINER=$(docker ps -a | grep /redmine$/)
if [ "$REDMINE_CONTAINER" = "redmine" ]; then
    docker rm redmine
fi
docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine --volumes-from mysql luck/redmine /assets/setup.sh
