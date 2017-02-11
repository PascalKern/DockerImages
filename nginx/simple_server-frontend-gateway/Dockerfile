FROM nginx:stable-alpine

RUN apk update \
    && apk add --no-cache \
    bash

COPY config/usrShareNginx /usr/share/nginx
COPY config/conf.d /etc/nginx/conf.d
COPY html /usr/local/share/nginx/html
COPY scripts/container-internal /usr/local/bin/scripts

# Prepare cleanuping - Create dirs and remove files
RUN rm -rf /usr/share/nginx/html \
    && rm -rf /etc/nginx/nginx.conf

# Update config - Linking new files as configurations
RUN ln -sf /usr/share/nginx/nginx.conf /etc/nginx/nginx.conf

ENV PATH=$PATH:/usr/local/bin/scripts

CMD ["bash", "-c", ". checkMode.sh && run-nginx.sh"]
