FROM php:7.2.34-apache

ADD assets /var/www/html/assets

ADD css /var/www/html/css

ADD js /var/www/html/js

ADD index.html /var/www/html/

RUN mkdir -p /var/www/html/app/health

ADD ./app/health/livenes /var/www/html/app/health

ADD ./app/health/readnes /var/www/html/app/health

EXPOSE 80
