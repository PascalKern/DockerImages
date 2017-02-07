FROM nginx:stable-alpine

RUN apk update \
	&& apk add --no-cache \
	bash

RUN mkdir /etc/nginx/conf.d/sites-enabled \
	&& ln -s /etc/nginx/conf.d/sites/test.conf /etc/nginx/conf.d/sites-enabled/test.conf

RUN echo Running nginx build with configuration script: \
	&& echo $(nginx -V) \
	&& echo Test nginx configurations: \
	&& echo $(nginx -t) 

# Not realy working!
# ENV NGINX_HOST foobar.com
# ENV NGINX_PORT 80
# RUN /bin/bash -c "set -o pipefail" \
# 	&& envsubst < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf
	
# CMD ["nginx", "-g", "daemon off;"]