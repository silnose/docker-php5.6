FROM ubuntu:16.04
MAINTAINER Yarsoniy "yarsoniy@gmail.com"
ENV REFRESHED_AT 2016-06-19

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN touch /etc/apt/sources.list.d/ondrej-php5.list
RUN echo "deb http://ppa.launchpad.net/ondrej/php5/ubuntu trusty main" >> /etc/apt/sources.list.d/ondrej-php5.list
RUN echo "deb-src http://ppa.launchpad.net/ondrej/php5/ubuntu trusty main" >> /etc/apt/sources.list.d/ondrej-php5.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get update

RUN apt-get -y install apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2

RUN apt-get -y --allow-unauthenticated install php5.6
RUN apt-get -y --allow-unauthenticated install php5.6-mysql
RUN apt-get -y --allow-unauthenticated install php5.6-mcrypt
RUN apt-get -y --allow-unauthenticated install php5.6-dev

RUN apt-get -y --allow-unauthenticated install php5.6-xml

RUN apt-get -y install curl
RUN apt-get -y install nano

RUN a2enmod rewrite

#Xdebug
RUN apt-get -y --allow-unauthenticated install php-xdebug
RUN echo "xdebug.remote_enable=1" >> /etc/php/5.6/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /etc/php/5.6/mods-available/xdebug.ini

# SSH
# Доступ через ssh потрібен лише для того, щоб через PhpStorm
# можна було запускати php-cli команди використовуючи php-інтерпритатор контейнера.
RUN apt-get -y install openssh-server
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd

#Supervisor для запуску кількох процесів
RUN apt-get -y install supervisor
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor

#Порти для: ssh apache2
EXPOSE 22 80

CMD ["/usr/bin/supervisord"]
