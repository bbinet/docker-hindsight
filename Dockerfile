FROM debian:stretch

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION ec076e7
ENV LUA_SANDBOX_MD5 371ad9d7560a1e1966cbf83768c0def1
ENV LUA_SANDBOX_EXTENSIONS_VERSION a6f86a8
ENV LUA_SANDBOX_EXTENSIONS_MD5 2a1e1a136cf011fb7f3cd4e6d73b05f3
ENV HINDSIGHT_VERSION v0.15.4-hl1
ENV HINDSIGHT_MD5 a8ddef1a36853181a067d854ef0a6410

ENV GITHUB "https://github.com/helioslite"
ENV DEBIAN_FRONTEND noninteractive

ADD install_debs.sh /install_debs.sh
RUN apt-get update && apt-get install -yq --no-install-recommends \
      libreadline5 wget ca-certificates libpq5 libssl1.0.2 zlib1g \
      libc-ares2 libgoogle-perftools4 libmaxminddb0 libmaxminddb-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /install_debs.sh "${GITHUB}/lua_sandbox/releases/download/${LUA_SANDBOX_VERSION}" "${LUA_SANDBOX_MD5}"
#RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}"
RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}" "grep -v kafka"
RUN /install_debs.sh "${GITHUB}/hindsight/releases/download/${HINDSIGHT_VERSION}" "${HINDSIGHT_MD5}"

# workaround for https://github.com/mozilla-services/lua_sandbox_extensions/issues/331
RUN mkdir -p /usr/local/share/grpc && ln -s /usr/share/luasandbox/grpc/roots.pem /usr/local/share/grpc/roots.pem

#EXPOSE 5565

ENTRYPOINT ["/usr/bin/hindsight"]
