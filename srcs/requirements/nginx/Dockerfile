
FROM debian:bullseye

RUN apt update && apt -y install nginx 
RUN apt install -y openssl && openssl req -x509 -days 365 -nodes \
	-subj "/CN=54.166.137.22" \
	-newkey rsa:2048 -keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt

COPY conf/serverConfig.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]