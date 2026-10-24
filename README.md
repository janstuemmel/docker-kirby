# docker kirby

a docker container with kirby installed on patched `php:8.2.35-fpm-alpine` and `caddy`.

## PHP security maintenance

The image disables `session.upload_progress` as an additional PHP2Shell mitigation. PHP 8.2 reaches the end of security support on December 31, 2026, so this patch is not a substitute for planning a PHP upgrade.

After this image change is merged and published, rebuild and deploy dependent images such as `janstuemmel/fsm`; existing images and running containers do not inherit updates automatically.

It is a [kirby public folder](https://getkirby.com/docs/guide/configuration#custom-folder-setup__public-folder-setup) setup: 

* `/app/kirby`: Kirby source files
* `/app/public`: Public folder
* `/app/content`: Website content
* `/app/site`: Website configuration and templates
* `/app/storage`: Cache, accounts & sessions

## Example

```Dockerfile
FROM ghcr.io/janstuemmel/kirby

# install a specific version of kirby 
RUN kirby-install 3.9.6

# install plugins
RUN kirby-plugins getkirby/cli@1.1.1 getkirby/geo
```
