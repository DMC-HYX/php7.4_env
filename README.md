# docker安装php环境
> 本docker使用了3个镜像分别如下
- php:7.4.33-fpm
- mysql:5.7.22
- redis


> 生成了3个容器分别如下
- nginx_env
- db
- redis

> 因nginx需要php-fpm才能解析php代码，所以在容器nginx_env通过了dockerfile将两个服务放在了同一个容器内。其中nginx_env中包括如下软件
- php:7.4.33-fpm
- reids-5.3.7
- memcached-3.2.0
- nginx
- composer
- git

# 使用
```
docker-compose up --build

# 如果不执行dockerfile可执行如下代码
docker-compose up --no-build
```