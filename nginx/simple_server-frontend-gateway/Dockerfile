FROM nginx:stable-alpine

RUN apk update \
    && apk add --no-cache \
    bash

# Prepare cleanuping - Create dirs and remove files
RUN rm -rf /usr/share/nginx/html \
    && rm -rf /etc/nginx/nginx.conf

# Update config - Linking new files as configurations
RUN ln -sf /usr/share/nginx/nginx.conf /etc/nginx/nginx.conf
    
# Check the configuration from nginx.    
RUN echo Running nginx build with configuration script: \
    && echo $(nginx -V) \
    && echo Test nginx configurations: \
    && echo $(nginx -t)

ADD run-nginx.sh .
CMD ["bash", "run-nginx.sh"]