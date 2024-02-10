FROM ubuntu:focal
LABEL maintainer="myoung34@my.apsu.edu"

ARG DUMB_INIT_VERSION="1.2.2"
ARG GIT_CORE_PPA_KEY="A1715D88E1DF1F24"

ENV GIT_LFS_VERSION="3.2.0"
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_VERSION=20.11.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl \
    tar \
    ca-certificates \
    jq \
    dumb-init \
    locales 
RUN groupadd -g 121 runner \
    && useradd -mr -d /home/runner -u 1001 -g 121 runner \
    && usermod -aG sudo runner \
    && echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers