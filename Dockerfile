FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:brightbox/ruby-ng
RUN apt-get -y update

RUN apt-get -y install git
RUN apt-get -y install ruby2.1 ruby2.1-dev
RUN apt-get -y install build-essential
RUN apt-get -y install libmysqlclient-dev
RUN apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev
RUN apt-get -y install subversion

RUN apt-get clean

ENV HOME /root

ADD assets/setup.sh /setup.sh
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
    gem install bundler

# Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

VOLUME ["/redmine"]
EXPOSE 80
