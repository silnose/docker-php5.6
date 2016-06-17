FROM ubuntu:16.04
MAINTAINER Yarsoniy "yarsoniy@gmail.com"
ENV REFRESHED_AT 2016-06-15

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN apt-add-repository -y ppa:ondrej/php
RUN apt-get update

# SSH
# Доступ через ssh потрібен лише для того, щоб через в PhpStorm
# можна було запускати php-cli команди використовуючи php-інтерпритатор контейнера.
RUN apt-get -y install openssh-server
RUN apt-get -y install supervisor
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get -y install apache2
RUN a2enmod rewrite

RUN apt-get -y --allow-unauthenticated install php5.6
RUN apt-get -y --allow-unauthenticated install php5.6-mysql
RUN apt-get -y --allow-unauthenticated install php5.6-mcrypt
RUN apt-get -y --allow-unauthenticated install php5.6-dev
RUN apt-get -y --allow-unauthenticated install php-xdebug

RUN apt-get -y install curl
RUN apt-get -y install vim

EXPOSE 22 #ssh
EXPOSE 80 #apache2

CMD ["/usr/bin/supervisord"]