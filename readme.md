### `nginx-phpfpm`

- 基于官方 `php:7.x-fpm-alpine` 镜像构建的 `nginx-phpfpm` 镜像,可用于`fpm`或`cli`,内置`nginx`,`supervisord`,`composer`

### 已装扩展

```
[PHP Modules]
bcmath
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
json
libxml
mbstring
mcrypt
mongodb
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
rdkafka
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
ssh2
tokenizer
xlswriter
xml
xmlreader
xmlwriter
Zend OPcache
zip
zlib

[Zend Modules]
Zend OPcache
```