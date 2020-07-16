[DCSS][DCSS] WebTiles Docker
=============================================
This is a [Dungeon Crawl Stone Soup][DCSS] standalone server.

Install
-------
Build from the [Dockerfile](Dockerfile):

```
$ git clone https://github.com/treyturner/crawl-docker.git
$ cd crawl-docker
$ docker build --build-arg CRAWL_GIT_TAG=0.25.0 -t crawl .
```

You can also provide a `--build-arg` of `CRAWL_GIT_REPO` if you wish, ie `https://github.com/Hellmonk/hellcrawl`.
If no CRAWL_GIT_TAG is specified, it will default to `0.25.0`, the latest release as of 7/16/20.

Usage
-----
A `docker-compose.yml` is included. Make sure you have `docker-compose` installed, then all you should need to do after the build is:

```
$ docker-compose up -d
```

This will start the server on port 80 and store your data in a persistent [Docker volume](https://docs.docker.com/storage/volumes/).

[DCSS]:http://crawl.develz.org/
[Crawl-dev]:http://webchat.freenode.net/?channels=%23%23crawl-dev
