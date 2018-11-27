FROM node:9

WORKDIR /mnt

RUN yarn add fontello-cli
COPY config.json config.json
RUN yarn run fontello-cli install
RUN mv fontello-* fontello

CMD cp fontello/font/fontello.ttf /fonts/icons.ttf
