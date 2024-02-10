FROM ubuntu:focal
LABEL maintainer="tkgling@splatnet3.com"

ARG GH_RUNNER_VERSION="2.313.0"
ARG DUMB_INIT_VERSION="1.2.2"
ARG GIT_CORE_PPA_KEY="A1715D88E1DF1F24"
ARG TARGETPLATFORM

ENV GIT_LFS_VERSION="3.2.0"
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl \
    tar \
    ca-certificates \
    locales \
    git \
    jq

WORKDIR /actions-runner
COPY install_actions.sh /actions-runner

RUN chmod +x /actions-runner/install_actions.sh \
  && /actions-runner/install_actions.sh ${GH_RUNNER_VERSION} ${TARGETPLATFORM} \
  && rm /actions-runner/install_actions.sh
#   && chown runner /_work /actions-runner /opt/hostedtoolcache

COPY token.sh entrypoint.sh app_token.sh /
RUN chmod +x /token.sh /entrypoint.sh /app_token.sh