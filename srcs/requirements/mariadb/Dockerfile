FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/confMariadb.sh /usr/local/bin/confMariadb.sh

RUN chmod +x /usr/local/bin/confMariadb.sh

EXPOSE 3306

CMD ["/bin/bash", "-c", "/usr/local/bin/confMariadb.sh && exec mysqld_safe"]