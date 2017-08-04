FROM debian:jessie

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 125c184
ENV LUA_SANDBOX_MD5 0d25e246c16b3b6b7768309dc11a9bc7
ENV LUA_SANDBOX_EXTENSIONS_VERSION f14a0b4
ENV LUA_SANDBOX_EXTENSIONS_MD5 d962a208b8475a24920e57da226084c0
ENV HINDSIGHT_VERSION v0.14.3-hl1
ENV HINDSIGHT_MD5 958686f1b735ff029ff7f4c5cb910b86

ENV DEBIAN_FRONTEND noninteractive
ENV GITHUB "https://github.com/helioslite"

ADD install_debs.sh /install_debs.sh
RUN apt-get update && apt-get install -yq --no-install-recommends \
      libreadline5 wget ca-certificates libpq5 && \
    rm -rf /var/lib/apt/lists/*


RUN /install_debs.sh "${GITHUB}/lua_sandbox/releases/download/${LUA_SANDBOX_VERSION}" "${LUA_SANDBOX_MD5}"
RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}"
RUN /install_debs.sh "${GITHUB}/hindsight/releases/download/${HINDSIGHT_VERSION}" "${HINDSIGHT_MD5}"

#EXPOSE 5565

ENTRYPOINT ["/usr/bin/hindsight"]
