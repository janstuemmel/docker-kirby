# docker kirby

a docker container with kirby installed on `php:8.2-fpm-alpine` and `caddy`.

## Args

* `KIRBY_VERSION`: Set version, `main` for latest. Default: `main`
* `PLUGINS`: Installs plugins, space seperated list: `namespace/name@version namespace2/name@version`.

## Example

```Dockerfile
ARG KIRBY_VERSION="main" 
ARG KIRBY_PLUGINS="getkirby/cli@1.1.1 getkirby/geo"

FROM ghcr.io/janstuemmel/kirby
```
