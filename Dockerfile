# hadolint ignore=DL3007
FROM tkgling/github-runner:base
LABEL maintainer="myoung34@my.apsu.edu"

RUN mkdir -p /opt/hostedtoolcache
RUN mkdir -p /usr/local/nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION=20.11.0

ARG GH_RUNNER_VERSION="2.313.0"

ARG TARGETPLATFORM

WORKDIR /actions-runner
COPY install_actions.sh /actions-runner

SHELL ["/bin/bash", "-c"]
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g yarn@v2

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN chmod +x /actions-runner/install_actions.sh \
  && /actions-runner/install_actions.sh ${GH_RUNNER_VERSION} ${TARGETPLATFORM} \
  && rm /actions-runner/install_actions.sh \
  && chown runner /_work /actions-runner /opt/hostedtoolcache

COPY token.sh entrypoint.sh app_token.sh /
RUN chmod +x /token.sh /entrypoint.sh /app_token.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["./bin/Runner.Listener", "run", "--startuptype", "service"]
