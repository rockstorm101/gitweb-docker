# GitWeb Docker Image
[![Test Build Status][1]][2]
[![Docker Image Size][3]][2]
[![Docker Pulls][4]][2]

Lightweight Docker image containing an Nginx webserver to visualize
git repositories (through [GitWeb][5]) and provide *read-only* access
to them over HTTP.

Image source at: https://github.com/rockstorm101/gitweb-docker

[1]: https://img.shields.io/github/actions/workflow/status/rockstorm101/gitweb-docker/test-build.yml?branch=master
[2]: https://hub.docker.com/r/rockstorm/gitweb
[3]: https://img.shields.io/docker/image-size/rockstorm/gitweb/latest
[4]: https://img.shields.io/docker/pulls/rockstorm/gitweb
[5]: https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb


## Basic Use Case

```
docker run -v /path/to/repos:/srv/git:ro -p 80:80 rockstorm/gitweb
```

Your repositories should be visible at http://localhost.

You should be able to clone/fetch/pull your repositories like:

```
git clone http://localhost/your-repo.git
```


## Customization

The provided `nginx.conf` and `gitweb.conf` files are the default
configurations for the Nginx webserver and [GitWeb][5] (the
repository visualizer) respectively. To override them just mount your
custom files at:

```yaml
services:
  gitweb:
    ...
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
      - ./gitweb.conf:/etc/gitweb.conf:ro
```


### Apply a Theme

To apply a theme to GitWeb like Stefan's [gitweb-theme][6]:

 1. Mount the theme files somewhere:

    ```
    services:
      gitweb:
      ...
        volumes:
          - /path/to/theme/folder:/usr/share/gitweb/theme:ro
    ```

 2. Add the relevant lines on your `gitweb.conf` file:
 
    ```
    our @stylesheets = "theme/gitweb.css";
    our $logo = "theme/git-logo.png";
    our $favicon = "theme/git-favicon.png";
    ```
 
[6]: https://github.com/kogakure/gitweb-theme


## License

View [license information][7] for the software contained in this
image.

As with all Docker images, these likely also contain other software
which may be under other licenses (such as git, etc from the base
distribution, along with any direct or indirect dependencies of the
primary software being contained).

As for any pre-built image usage, it is the image user's
responsibility to ensure that any use of this image complies with any
relevant licenses for all software contained within.

[7]: https://github.com/rockstorm101/gitweb-docker/blob/master/LICENSE


## Credits

This image is heavily inspired by Kostya's [gitweb-readonly][8] but
simpler and lighter.

[8]: https://github.com/KostyaEsmukov/docker-gitweb-readonly
