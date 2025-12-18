FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/confMariadb.sh /docker-entrypoint-initdb.d/

RUN ["bash", "/docker-entrypoint-initdb.d/confMariadb.sh"]

EXPOSE 3306

CMD ["mysqld_safe"]
