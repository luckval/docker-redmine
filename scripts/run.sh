#!/bin/sh 

MYSQL_CONTAINER=$(docker ps -aq | grep mysql)
if [ "$MYSQL_CONTAINER" != "mysql" ]; then
    docker run -d --name mysql -v `pwd`/data/mysql:/var/lib/mysql yosh/mysql
fi

REDMINE_CONTAINER=$(docker ps -aq | grep redmine)
if [ "$REDMINE_CONTAINER" = "redmine" ]; then
    docker rm redmine
fi
docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine --volumes-from mysql yosh/redmine /setup.sh
