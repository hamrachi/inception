ARG DEBIAN_PENULTIMATE=debian:bullseye
FROM ${DEBIAN_PENULTIMATE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /etc/nginx/certs

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
