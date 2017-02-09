FROM alpine:3.5

# Origin source: https://hub.docker.com/r/richarvey/nginx-nodejs/ + https://github.com/ngineered/nginx-nodejs
# FROM docker pull richarvey/nginx-nodejs

MAINTAINER pkern <pascal.kern@gmail.com>

# RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && apk update && apk add --no-cache bash \
RUN apk add --no-cache bash \
gawk \
sed \
grep \
coreutils \
openssh-client \
wget \
nginx \
supervisor \
curl \
nodejs-lts \
openssl-dev \
ca-certificates && \
apk update && \
mkdir -p /etc/nginx && \
mkdir -p /var/www/app && \
mkdir -p /run/nginx && \
mkdir -p /var/log/supervisor

## Later let all be run under this user!
# RUN adduser -S -s /bin/false web web \
# && npm install --global npm@3.7.5
# ENV HOME=/home/web
# USER web    
    
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
# ADD conf/nginx-site-ssl.conf /etc/nginx/sites-available/default-ssl.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf
ADD conf/nginx_sysreport.conf /etc/nginx/sites-available/nginx_sysreport.conf
RUN ln -s /etc/nginx/sites-available/nginx_sysreport.conf /etc/nginx/sites-enabled/nginx_sysreport.conf

ADD favicon.ico /var/www/html/favicon.ico

# Add Scripts
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# copy in code
ADD src/ /var/www/html/
ADD errors/ /var/www/errors/
RUN mkdir -p /var/log/node/

VOLUME /var/www/html/

EXPOSE 443 80

CMD ["/bin/bash", "./start.sh"]