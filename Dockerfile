FROM php:8.2-fpm-alpine

RUN apk add --update --no-cache freetype-dev libzip-dev zlib git php82-sqlite3 sqlite libjpeg-turbo-dev bash libpng-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd exif zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN wget -O /usr/local/bin/caddy "https://caddyserver.com/api/download?os=linux&arch=amd64&p=github.com%2Fbaldinof%2Fcaddy-supervisor" \
  && chmod +x /usr/local/bin/caddy

COPY php.ini /usr/local/etc/php/conf.d/settings.ini
COPY Caddyfile /etc/Caddyfile
COPY kirby-plugins /usr/local/bin
COPY index.php /app/public/
COPY composer.json /app/composer.json

RUN addgroup app && adduser -S -u 1000 -s /bin/bash app -G app \
  && mkdir -p /app && chown app.app -R /app

USER app
WORKDIR /app

RUN composer require getkirby/cms:^3

CMD ["caddy", "run", "--config", "/etc/Caddyfile"]
