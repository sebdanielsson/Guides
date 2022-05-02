# Traefik Redirection

Credits: ldez (Traefik Maintainer)

## Global approach

### Docker labels

``` yaml
services:
  traefik:
    image: traefik:v2.1.3
    command:
      - --entrypoints.web.address=:80
      - --entrypoints.websecure.address=:443
      - --providers.docker=true
      - --providers.docker.exposedbydefault=false
      - --log.level=INFO
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    labels:
      traefik.enable: true

      # Global redirection: http to https
      traefik.http.routers.http-catchall.rule: HostRegexp(`{host:(www\.)?.+}`)
      traefik.http.routers.http-catchall.entrypoints: web
      traefik.http.routers.http-catchall.middlewares: wwwtohttps
      
      # Global redirection: https (www.) to https
      traefik.http.routers.wwwsecure-catchall.rule: HostRegexp(`{host:(www\.).+}`)
      traefik.http.routers.wwwsecure-catchall.entrypoints: websecure
      traefik.http.routers.wwwsecure-catchall.tls: true
      traefik.http.routers.wwwsecure-catchall.middlewares: wwwtohttps

      # middleware: http(s)://(www.) to  https://
      traefik.http.middlewares.wwwtohttps.redirectregex.regex: ^https?://(?:www\.)?(.+)
      traefik.http.middlewares.wwwtohttps.redirectregex.replacement: https://$${1}
      traefik.http.middlewares.wwwtohttps.redirectregex.permanent: true

  whoami:
    image: containous/whoami
    labels:
      traefik.enable: true
      traefik.http.routers.whoami.rule: Host(`whoami.localhost`)
      traefik.http.routers.whoami.entrypoints: websecure
      traefik.http.routers.whoami.tls: true
```

### File provider

traefik.toml (static configuration)

``` toml
[entryPoints.web]
  address = ":80"
[entryPoints.websecure]
  address = ":443"

[providers.file]
  directory = "/dyn/"

[log]
  level = "INFO"
/dyn/global_redirection.toml (dynamic configuration)
# Global redirection: http to https
[http.routers.http-catchall]
  rule = "HostRegexp(`{host:(www\\.)?.+}`)"
  entryPoints = ["web"]
  middlewares = ["wwwtohttps"]
  service = "noop"

# Global redirection: https (www.) to https
[http.routers.wwwsecure-catchall]
  rule = "HostRegexp(`{host:(www\\.).+}`)"
  entryPoints = ["websecure"]
  middlewares = ["wwwtohttps"]
  service = "noop"
  [http.routers.wwwsecure-catchall.tls]

# middleware: http(s)://(www.) to  https://
[http.middlewares.wwwtohttps.redirectregex]
  regex = "^https?://(?:www\\.)?(.+)"
  replacement = "https://${1}"
  permanent = true

# NOOP service
[http.services.noop]
  [[http.services.noop.loadBalancer.servers]]
    url = "http://192.168.0.1:666"
```

### Kubernetes CRD provider

``` yaml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: http_catchall
  namespace: bar

spec:
  entryPoints:
    - web
  routes:
  - match: 'HostRegexp(`{host:(www\.)?.+}`)'
    kind: Rule
    middlewares:
    - name: wwwtohttps
    services:
    - name: foo-svc
      port: 666

---
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: wwwsecure_catchall
  namespace: bar

spec:
  entryPoints:
    - websecure
  routes:
  - match: 'HostRegexp(`{host:(www\.).+}`)'
    kind: Rule
    middlewares:
    - name: wwwtohttps
    services:
    - name: foo-svc
      port: 666
  tls: {}

---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: wwwtohttps
  namespace: bar

spec:
  redirectRegex:
    regex: '^https?://(?:www\.)?(.+)'
    replacement: 'https://${1}'
    permanent: true
```

### Results

``` misc
http://whoami.localhost -> https://whoami.localhost
http://www.whoami.localhost -> https://whoami.localhost
https://www.whoami.localhost -> https://whoami.localhost
```

## Another way (less global) to do that

``` yaml
services:
  traefik:
    image: traefik:v2.1.3
    command:
      - --entrypoints.web.address=:80
      - --entrypoints.websecure.address=:443
      - --providers.docker=true
      - --providers.docker.exposedbydefault=false
      - --log.level=INFO
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    labels:
      traefik.enable: true

      # Global redirection: http to https
      traefik.http.routers.http_catchall.rule: HostRegexp(`{host:.+}`)
      traefik.http.routers.http_catchall.entrypoints: web
      traefik.http.routers.http_catchall.middlewares: tohttps

      # middleware: http:// to  https://
      traefik.http.middlewares.tohttps.redirectscheme.scheme: https
      traefik.http.middlewares.tohttps.redirectscheme.permanent: true

      # middleware: https://www. to  https://
      traefik.http.middlewares.trim_www.redirectregex.regex: ^https://www\.(.+)
      traefik.http.middlewares.trim_www.redirectregex.replacement: https://$${1}
      traefik.http.middlewares.trim_www.redirectregex.permanent: true

  whoami:
    image: containous/whoami
    labels:
      traefik.enable: true

      traefik.http.routers.whoami.rule: Host(`whoami.localhost`, `www.whoami.localhost`)
      traefik.http.routers.whoami.entrypoints: websecure
      traefik.http.routers.whoami.middlewares: trim_www
      traefik.http.routers.whoami.tls: true
```

Note: the redirections are made by routers, the routers are a part of the dynamic configuration 21, so a CLI flags version is not possible because flags handle the static configuration 12.
