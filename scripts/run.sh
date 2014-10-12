#!/bin/sh 

USER=luck

MYSQL_CONTAINER=$(docker ps -a | grep /mysql$/)
if [ "$MYSQL_CONTAINER" != "" ]; then
    docker run -d --name mysql -v /var/lib/mysql $USER/mysql
fi

REDMINE_CONTAINER=$(docker ps -a | grep /redmine$/)
if [ "$REDMINE_CONTAINER" = "redmine" ]; then
    docker rm redmine
fi

if [ "$1" != "" ]; then
    docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine --volumes-from mysql $USER/redmine $*
else
    docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine --volumes-from mysql $USER/redmine /assets/setup.sh
fi

docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine -p 80:80 \
	--volumes-from mysql $USER/redmine bundle exec rails s -p 80 -e production
