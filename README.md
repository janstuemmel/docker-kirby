# docker kirby

a docker container with kirby installed on `php:8.2-fpm-alpine` and `caddy`.

## Example

```Dockerfile
FROM ghcr.io/janstuemmel/kirby

# install a specific version of kirby 
RUN kirby-install 3.9.6

# install plugins
RUN kirby-plugins getkirby/cli@1.1.1 getkirby/geo
```
