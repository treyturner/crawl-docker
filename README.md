[DCSS][DCSS] WebTiles Docker
=============================================
This is a [Dungeon Crawl Stone Soup][DCSS] standalone server.

How is this different from [dfdgsdfg](https://github.com/dfdgsdfg)'s image?
--------------------------------------------
This is based off of [dfdgsdfg/crawl-docker](https://github.com/dfdgsdfg/crawl-docker). I made a few changes:

- Add pyyaml (fixes build breakage)
- Update to Python 3 (to fix pyyaml not being detected)
- Update to tornado 6.0.4
- Build from Git tags instead of branches
- Reduce number of layers in the build
- Store saves and morgues in a persistent [Docker volume]
  - Applies to main game as well as seed/tutorial/sprint games
- Add a `docker-compose.yml` for easy management

Install
-------
Build from the [Dockerfile](Dockerfile):

```
$ git clone https://github.com/treyturner/crawl-docker.git
$ cd crawl-docker
$ docker build --build-arg CRAWL_GIT_TAG=0.25.0 -t crawl .
```

You can also provide a `--build-arg` of `CRAWL_GIT_REPO` if you wish, ie `https://github.com/Hellmonk/hellcrawl`.

If no `CRAWL_GIT_TAG` is specified, it will default to `0.25.0`, the latest release as of 7/16/20.

Usage
-----
Make sure you have [`docker-compose` installed](https://docs.docker.com/compose/install/), then all you should need to do after the build is:

```
$ docker-compose up -d
```

This will start the server on port 80.

You can stop the server with:

```
$ docker-compose down
```

[DCSS]:http://crawl.develz.org/
[Crawl-dev]:http://webchat.freenode.net/?channels=%23%23crawl-dev
[Docker volume]:https://docs.docker.com/storage/volumes/
