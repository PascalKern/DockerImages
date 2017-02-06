FROM alpine:3.4

# Origin source: https://hub.docker.com/r/richarvey/nginx-nodejs/ + https://github.com/ngineered/nginx-nodejs
# FROM docker pull richarvey/nginx-nodejs

MAINTAINER pkern <pascal.kern@gmail.com>


RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && apk update && apk add --no-cache bash \
    openssh-client \
    wget \
    nginx \
    supervisor \
    curl \
    nodejs-lts \
    openssl-dev \
    ca-certificates \
    mkdir -p /etc/nginx && \
    mkdir -p /var/www/app && \
    mkdir -p /run/nginx && \
    mkdir -p /var/log/supervisor

ADD conf/supervisord.conf /etc/supervisord.conf

# Copy our nginx config
RUN rm -Rf /etc/nginx/nginx.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

# nginx site conf
RUN mkdir -p /etc/nginx/sites-available/ && \
mkdir -p /etc/nginx/sites-enabled/ && \
mkdir -p /etc/nginx/ssl/ && \
rm -Rf /var/www/* && \
mkdir /var/www/html/
ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf
ADD conf/nginx-site-ssl.conf /etc/nginx/sites-available/default-ssl.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# copy in code
ADD src/ /var/www/html/
ADD errors/ /var/www/errors/
RUN mkdir -p /var/log/node/

VOLUME /var/www/html/

EXPOSE 443 80

CMD ["/start.sh"]