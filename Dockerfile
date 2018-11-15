FROM debian:stretch

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION e5e9235
ENV LUA_SANDBOX_MD5 be7cc9460624e67aa2d2e69e8548f5fd
ENV LUA_SANDBOX_EXTENSIONS_VERSION c68549e
ENV LUA_SANDBOX_EXTENSIONS_MD5 664d5fc98a13956722e7bd4e14e2b535
ENV HINDSIGHT_VERSION v0.15.3-hl1
ENV HINDSIGHT_MD5 9e355e678422bb8063d9a84d5a54a2e7

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
