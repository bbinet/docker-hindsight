FROM debian:jessie

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUASANDBOX_VERSION 0.20.2-hl.1
ENV LUASANDBOX_MD5 0669f9e2032528b00707fc073cf5434d
ENV HINDSIGHT_VERSION 0.7.2-hl.1
ENV HINDSIGHT_MD5 c7be566bbbe6109933ac338fec2f40c7

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get install -yq --no-install-recommends libreadline5 curl ca-certificates && \
  curl -fSL -o /tmp/luasandbox-${LUASANDBOX_VERSION}-amd64.tar.gz https://github.com/helioslite/lua_sandbox/releases/download/v${LUASANDBOX_VERSION}/luasandbox-${LUASANDBOX_VERSION}-amd64.tar.gz && \
  echo "${LUASANDBOX_MD5}  /tmp/luasandbox-${LUASANDBOX_VERSION}-amd64.tar.gz" | md5sum --check && \
  mkdir -p /opt/luasandbox && \
  tar xf /tmp/luasandbox-${LUASANDBOX_VERSION}-amd64.tar.gz --strip-components=1 -C /opt/luasandbox && \
  rm /tmp/luasandbox-${LUASANDBOX_VERSION}-amd64.tar.gz && \
  curl -fSL -o /tmp/hindsight-${HINDSIGHT_VERSION}-amd64.tar.gz https://github.com/helioslite/hindsight/releases/download/v${HINDSIGHT_VERSION}/hindsight-${HINDSIGHT_VERSION}-amd64.tar.gz && \
  echo "${HINDSIGHT_MD5}  /tmp/hindsight-${HINDSIGHT_VERSION}-amd64.tar.gz" | md5sum --check && \
  mkdir -p /opt/hindsight && \
  tar xf /tmp/hindsight-${HINDSIGHT_VERSION}-amd64.tar.gz --strip-components=1 -C /opt/hindsight && \
  rm /tmp/hindsight-${HINDSIGHT_VERSION}-amd64.tar.gz && \
  rm -rf /var/lib/apt/lists/*

#EXPOSE 5565

ENV LD_LIBRARY_PATH /opt/luasandbox/lib

ENTRYPOINT ["/opt/hindsight/bin/hindsight"]
