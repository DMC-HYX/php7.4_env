FROM php:7.4.33-fpm
MAINTAINER yuexinghuang yuexinghuang@dingtalk.com
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y \
    git \
    nginx

# 安装所需的软件包
RUN apt-get install -y \
    pkg-config \
    libmemcached-dev \
    autoconf \
    gcc \
    make \
    zlib1g \
    zlib1g-dev \
    vim \
    libzip-dev

# 安装 memcached 拓展
RUN pecl channel-update pecl.php.net && pecl install memcached-3.1.5 && docker-php-ext-enable memcached

# 安装 redis 拓展
RUN pecl install redis-5.3.7 && docker-php-ext-enable redis

# 安装额外的 PHP 拓展
RUN docker-php-ext-install pdo pdo_mysql zip

# 安装 Composer
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer

CMD nginx && php-fpm && tail -f /var/log/nginx/error.log
