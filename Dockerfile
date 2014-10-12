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

RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
    gem install bundler

# Timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN mkdir assets/
ADD assets/setup.sh assets/setup.sh
ADD assets/database.yml assets/database.yml
ADD assets/configuration.yml assets/configuration.yml
ADD assets/additional_environment.rb assets/additional_environment.rb
RUN chmod 755 assets/setup.sh

VOLUME ["/redmine"]
EXPOSE 80
