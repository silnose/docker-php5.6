FROM ubuntu:16.04
MAINTAINER Yarsoniy "yarsoniy@gmail.com"
ENV REFRESHED_AT 2016-06-15

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN apt-add-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get -y install apache2
RUN apt-get -y --allow-unauthenticated install php5.6
RUN apt-get -y --allow-unauthenticated install php5.6-mysql
RUN apt-get -y --allow-unauthenticated install php5.6-mcrypt
RUN apt-get -y --allow-unauthenticated install php5.6-dev
RUN apt-get -y --allow-unauthenticated install php-xdebug

RUN apt-get -y install curl
RUN apt-get -y install vim

RUN a2enmod rewrite

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]