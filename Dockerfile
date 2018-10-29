FROM centos:7

SHELL ["/bin/bash", "-c"]

ARG git_user
ARG git_password

RUN yum -y install nc
RUN yum -y install git
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install epel-release && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y --setopt=tsflags=nodocs --nogpgcheck install php71u-cli \
        php71u-bcmath \
        php71u-gd \
        php71u-intl \
        php71u-json \
        php71u-ldap  \
        php71u-mbstring \
        php71u-mcrypt \
        php71u-opcache \
        php71u-pdo \
        php71u-pear  \
        php71u-pecl-apcu \
        php71u-pecl-imagick \
        php71u-pecl-redis \
        php71u-pecl-xdebug  \
        php71u-pgsql \
        php71u-mysqlnd \
        php71u-soap \
        php71u-tidy \
        php71u-xml \
        php71u-process \
        php71u-fpm \
        php71u-xmlrpc && \
        yum clean all

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer 

COPY conf/php.ini /etc/php.ini
COPY conf/php-fpm.d/www.conf /etc/php-fpm.d/www.conf
EXPOSE 9000