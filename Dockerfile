FROM debian:buster

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 33af22b
ENV LUA_SANDBOX_MD5 951518b40e2290646e4c251c45bbf4fd
ENV LUA_SANDBOX_EXTENSIONS_VERSION 193b9fc
ENV LUA_SANDBOX_EXTENSIONS_MD5 372e5154ab3afd5c583dd97bb5117e93
ENV HINDSIGHT_VERSION v0.16.0-hl1
ENV HINDSIGHT_MD5 abe446e96659864cb1a6282f6d926a24

ENV GITHUB "https://github.com/helioslite"
ENV DEBIAN_FRONTEND noninteractive

ADD install_debs.sh /install_debs.sh
RUN apt-get update && apt-get install -yq --no-install-recommends \
      libreadline5 wget ca-certificates libpq5 libssl1.0.2 zlib1g \
      libc-ares2 libgoogle-perftools4 libmaxminddb0 libmaxminddb-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /install_debs.sh "${GITHUB}/lua_sandbox/releases/download/${LUA_SANDBOX_VERSION}" "${LUA_SANDBOX_MD5}"
RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}"
#RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}" "grep -v kafka"
RUN /install_debs.sh "${GITHUB}/hindsight/releases/download/${HINDSIGHT_VERSION}" "${HINDSIGHT_MD5}"

# workaround for https://github.com/mozilla-services/lua_sandbox_extensions/issues/331
RUN mkdir -p /usr/local/share/grpc && ln -s /usr/share/luasandbox/grpc/roots.pem /usr/local/share/grpc/roots.pem

#EXPOSE 5565

ENTRYPOINT ["/usr/bin/hindsight"]
