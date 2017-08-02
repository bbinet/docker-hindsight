FROM debian:jessie

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 125c184
ENV LUA_SANDBOX_MD5 f97cc11353659975c954de20fd6b2f25
ENV LUA_SANDBOX_EXTENSIONS_VERSION d0e416b
ENV LUA_SANDBOX_EXTENSIONS_MD5 6310946e757ce5a46527e0de43f8471d
ENV HINDSIGHT_VERSION v0.14.3-hl1
ENV HINDSIGHT_MD5 fa0257c6615e6d546158b225a0380cf1

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
