FROM nginx:stable-alpine

RUN apk update \
    && apk add --no-cache \
    bash

# Prepare cleanuping - Create dirs and remove files
RUN mkdir -p /etc/nginx/conf.d/sites-enabled \
    && rm -rf /usr/share/nginx/html \
    && rm -rf /etc/nginx/nginx.conf

# Update config - Linking new files as configurations
RUN ln -s /etc/nginx/conf.d/sites/test.conf /etc/nginx/conf.d/sites-enabled/test.conf \
    && ln -sf /usr/share/nginx/nginx.conf /etc/nginx/nginx.conf
    
RUN echo Running nginx build with configuration script: \
    && echo $(nginx -V) \
    && echo Test nginx configurations: \
    && echo $(nginx -t)

# Not realy working!
# ENV NGINX_HOST foobar.com
# ENV NGINX_PORT 80
# RUN /bin/bash -c "set -o pipefail" \
#   && envsubst < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf
    
CMD ["nginx", "-g", "daemon off;"]
