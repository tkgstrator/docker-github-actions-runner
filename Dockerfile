# hadolint ignore=DL3007
FROM tkgling/github-runner:base

RUN mkdir -p /opt/hostedtoolcache
RUN mkdir -p /usr/local/nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION=20.11.0

SHELL ["/bin/bash", "-c"]
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g yarn@v2

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /actions-runner
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./bin/Runner.Listener", "run", "--startuptype", "service"]
