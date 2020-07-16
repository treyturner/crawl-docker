FROM python:3
MAINTAINER dididi <dfdgsdfg@gmail.com>

ENV HOME /root
ENV LC_ALL C.UTF-8

ARG CRAWL_GIT_REPO=https://github.com/crawl/crawl
ARG CRAWL_GIT_TAG=0.25.0

RUN apt-get update && \
    apt-get -y install build-essential \
                       libncursesw5-dev \
                       bison \
                       flex \
                       liblua5.1-0-dev \
                       libsqlite3-dev \
                       libz-dev \
                       pkg-config \
                       libsdl2-image-dev \
                       libsdl2-mixer-dev \
                       libsdl2-dev \
                       libfreetype6-dev \
                       libpng-dev \
                       ttf-dejavu-core \
                       ccache \
                       binutils-gold && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install tornado==6.0.4 pyyaml

WORKDIR /root
RUN git clone ${CRAWL_GIT_REPO} --depth 1
 
WORKDIR /root/crawl
RUN git fetch origin tag ${CRAWL_GIT_TAG} --no-tags
RUN git checkout tags/${CRAWL_GIT_TAG} -b ${CRAWL_GIT_TAG}
RUN git submodule update --init

WORKDIR /root/crawl/crawl-ref/source
RUN make WEBTILES=y USE_DGAMELAUNCH=y
RUN mkdir rcs

WORKDIR /root/crawl/crawl-ref/source/webserver
RUN sed -i '/bind_port/ s|8080|80|' config.py
RUN sed -i '/password_db/ s|./webserver/passwd.db3|/data/passwd.db3|' config.py
RUN sed -i '/filename/ s|#||' config.py
RUN sed -i '/filename/ s|webtiles.log|/data/webtiles.log|' config.py
# RUN sed -i '/crypt_algorithm/ s|broken|6|' config.py
# RUN sed -i '/crypt_salt_length/ s|16|16|' config.py

WORKDIR /root/crawl/crawl-ref/source
CMD python webserver/server.py

VOLUME ["/data"]
EXPOSE 80 443

