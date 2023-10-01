FROM php:8.2-fpm-alpine

RUN apk add --update --no-cache freetype-dev libzip-dev zlib git libjpeg-turbo-dev bash libpng-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd exif zip

RUN wget -O /usr/local/bin/caddy "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fbaldinof%2Fcaddy-supervisor" \
  && chmod +x /usr/local/bin/caddy

COPY php.ini /usr/local/etc/php/conf.d/settings.ini
COPY Caddyfile /etc/Caddyfile
COPY install-plugins.sh /usr/local/bin

RUN addgroup app && adduser -S -u 1000 -s /bin/bash app -G app \
  && mkdir -p /app && chown app -R /app

USER app
WORKDIR /app

ARG KIRBY_VERSION="main"
ARG KIRBY_PLUGINS=""

RUN wget -O kirby.zip https://codeload.github.com/getkirby/plainkit/zip/$KIRBY_VERSION
RUN ls . -a
RUN unzip kirby.zip -d . \
  && rm kirby.zip \
  && mv plainkit-$KIRBY_VERSION kirby

WORKDIR /app/kirby

RUN install-plugins.sh $KIRBY_PLUGINS

VOLUME /app/kirby/media
VOLUME /app/kirby/content
VOLUME /app/kirby/site/accounts

CMD ["caddy", "run", "--config", "/etc/Caddyfile"]
