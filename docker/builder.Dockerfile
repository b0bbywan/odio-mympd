ARG BASE_IMAGE=debian:trixie
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

# Compile deps mirror `build.sh installdeps` for Debian-family +
# packaging tooling required by `build.sh pkgdebian`.
# apt lists kept so a future upstream version that adds a new dep can
# still install it via `installdeps` without an extra `apt-get update`.
RUN apt-get update && apt-get install -y --no-install-recommends \
      sudo ca-certificates \
      gcc cmake perl libssl-dev libid3tag0-dev libflac-dev \
      liblua5.4-dev lua5.4 build-essential pkg-config \
      libpcre2-dev gzip jq whiptail libutf8proc-dev \
      dpkg-dev debhelper fakeroot lintian
