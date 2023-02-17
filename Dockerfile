FROM php:7.4.33-fpm
MAINTAINER yuexinghuang yuexinghuang@dingtalk.com
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install nginx -y

# 安装预编译环境 （不然装不了memcached的拓展）
RUN apt-get install -y pkg-config libmemcached-dev autoconf gcc make zlib1g zlib1g-dev vim

RUN pecl channel-update pecl.php.net && pecl install memcached-3.2.0 && docker-php-ext-enable memcached

RUN pecl install redis-5.3.7 && docker-php-ext-enable redis

RUN docker-php-ext-install pdo pdo_mysql

# 安装composer
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer

CMD nginx && php-fpm && tail -f /var/log/nginx/error.log