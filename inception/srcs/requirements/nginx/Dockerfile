ARG DEBIAN_PENULTIMATE=debian:bullseye
FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/certs
RUN openssl req -x509 -newkey rsa:2048 -nodes -days 30 \
	-keyout /etc/nginx/certs/server.key
	-out /etc/nginx/certs/server.crt
	-subj="/=MA/ST=Casa/OU=1337/CN=hamrachi.42.fr"

COPY conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
