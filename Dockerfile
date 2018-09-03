FROM debian:stretch

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 52f6921
ENV LUA_SANDBOX_MD5 160a7b05939a04b71704a38d62684c4e
ENV LUA_SANDBOX_EXTENSIONS_VERSION 985dc8f
ENV LUA_SANDBOX_EXTENSIONS_MD5 cd50b26d6c93b334d711fe445a2ac93f
ENV HINDSIGHT_VERSION v0.14.14-hl2
ENV HINDSIGHT_MD5 05ce0780e0af96bc41282fdeaefad9f7

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
