
FROM debian:bullseye

RUN apt update && apt -y install nginx 

ARG SERVER_IP=localhost

RUN apt install -y openssl && openssl req -x509 -days 365 -nodes \
	-subj "/CN=${SERVER_IP}" \
	-newkey rsa:2048 -keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt

COPY conf/serverConfig.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
