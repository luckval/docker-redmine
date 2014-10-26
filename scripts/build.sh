#!/bin/sh

TOPDIR=$(cd `dirname $0`; pwd)/..
USER=luck

docker build -t ${USER}/redmine ${TOPDIR}/
docker build -t ${USER}/mysql ${TOPDIR}/mysql/
