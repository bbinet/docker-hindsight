FROM debian:stretch

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV LUA_SANDBOX_VERSION 780737d
ENV LUA_SANDBOX_MD5 216bb98a63d0d7fdc3536ee43233a70d
ENV LUA_SANDBOX_EXTENSIONS_VERSION a5dcb5b
ENV LUA_SANDBOX_EXTENSIONS_MD5 9f192b0261c769509972a9782f1eb49f 
ENV HINDSIGHT_VERSION v0.14.7-hl1
ENV HINDSIGHT_MD5 f9a6c130ab7194964bfd52557eba9e1f

ENV DEBIAN_FRONTEND noninteractive
ENV GITHUB "https://github.com/helioslite"

ADD install_debs.sh /install_debs.sh
RUN apt-get update && apt-get install -yq --no-install-recommends \
      libreadline5 wget ca-certificates libpq5 libssl1.0.2 zlib1g && \
    rm -rf /var/lib/apt/lists/*


RUN /install_debs.sh "${GITHUB}/lua_sandbox/releases/download/${LUA_SANDBOX_VERSION}" "${LUA_SANDBOX_MD5}"
RUN /install_debs.sh "${GITHUB}/lua_sandbox_extensions/releases/download/${LUA_SANDBOX_EXTENSIONS_VERSION}" "${LUA_SANDBOX_EXTENSIONS_MD5}"
RUN /install_debs.sh "${GITHUB}/hindsight/releases/download/${HINDSIGHT_VERSION}" "${HINDSIGHT_MD5}"

#EXPOSE 5565

ENTRYPOINT ["/usr/bin/hindsight"]
