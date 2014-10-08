FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install mysql-server
RUN apt-get clean

RUN service mysql start && \
        mysql -uroot -e "CREATE DATABASE redmine DEFAULT CHARACTER SET utf8; \
        GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost' IDENTIFIED BY 'redmine'; \
	FLUSH PRIVILEGES;"

VOLUME ["/var/lib/mysql"]
VOLUME ["/var/run/mysqld"]
ENTRYPOINT ["mysqld_safe"]
