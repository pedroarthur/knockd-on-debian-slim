FROM debian:stable-slim

RUN set -x; true \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    iproute2 iptables knockd \
  ;

COPY knockd-entrypoint.sh /usr/local/bin/
COPY detect-interface.sh  /usr/local/bin/

ENTRYPOINT ["knockd-entrypoint.sh"]

