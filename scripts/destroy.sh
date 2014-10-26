#!/bin/sh

docker stop mysql && docker rm mysql
docker stop redmine && docker rm redmine

