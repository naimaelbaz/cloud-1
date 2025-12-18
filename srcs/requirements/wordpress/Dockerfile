FROM debian:bullseye

RUN apt update && apt install php-fpm php-mysqli mariadb-client curl -y 
RUN echo "listen=9000" >> /etc/php/7.4/fpm/php-fpm.conf
RUN mkdir -p /run/php/

COPY ./tools/script.sh /script.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["bash" ,"/script.sh"]