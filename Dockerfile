FROM debian:jessie

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 1.1.0-hl2
ENV LUA_SANDBOX_MD5 2b6d0349ac6760409cc0edbb62eee3a6
ENV LUA_SANDBOX_EXTENSIONS_VERSION 0.1-hl2
ENV LUA_SANDBOX_EXTENSIONS_MD5 5b93810b6869bfbbdc2b7399415e0a54
ENV HINDSIGHT_VERSION 0.11.1-hl2
ENV HINDSIGHT_MD5 430d37b8d4e4d3fca1a2b0de1e8737d8

ENV DEBIAN_FRONTEND noninteractive
ENV GITHUB "https://github.com/helioslite"

ADD install_debs.sh /install_debs.sh
RUN apt-get update && apt-get install -yq --no-install-recommends \
      libreadline5 wget ca-certificates libpq5 && \
    rm -rf /var/lib/apt/lists/*


RUN /install_debs.sh "${GITHUB}/lua_sandbox/releases/download/v${LUA_SANDBOX_VERSION}" "${LUA_SANDBOX_MD5}"
RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/v${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}"
RUN /install_debs.sh "${GITHUB}/hindsight/releases/download/v${HINDSIGHT_VERSION}" "${HINDSIGHT_MD5}"

#EXPOSE 5565

ENTRYPOINT ["/usr/bin/hindsight"]
