FROM php:7.4-fpm-alpine

LABEL Maintainer="qiuapeng921@163.com"

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# 修复安全漏洞
RUN apk update \
    && apk upgrade busybox curl libcrypto1.1 libcurl libretls \
    libxml2 ncurses-libs ncurses-terminfo-base openssl zlib xz xz-libs libssl1.1

# 安装常用服务（添加 netcat-openbsd 用于端口检测）
RUN apk add tzdata supervisor nginx wget bash openssl netcat-openbsd \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir -p /run/nginx

# 安装依赖库
RUN apk add --no-cache libstdc++ libzip-dev libpng-dev zlib-dev freetype-dev libjpeg libjpeg-turbo-dev

RUN apk add --no-cache --virtual .build-deps \
    # 安装php常用扩展
    && install-php-extensions gd bcmath opcache mysqli pdo_mysql sockets zip ssh2 redis mcrypt mongodb rdkafka xlswriter @composer \
    # 删除系统扩展
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && php -m

RUN rm -rf /var/www/html/*

COPY config/supervisord/supervisord.conf /etc/supervisord.conf
COPY config/supervisord/conf.d/* /etc/supervisor/conf.d/
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY config/php/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY config/php/php.ini /usr/local/etc/php/

COPY index.php /usr/share/nginx/html/public/

WORKDIR /usr/share/nginx/html/

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
