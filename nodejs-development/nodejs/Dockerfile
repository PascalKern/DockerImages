# test

FROM node:7.4.0

RUN useradd --user-group --create-home --shell /bin/false nodejs && \
    npm install --global npm@4.1.1

ENV HOME=/home/nodejs

USER nodejs
WORKDIR $HOME/nodejs
