FROM alpine:3.21

ENV BUILD_REPOS="user"

RUN apk add --no-cache alpine-sdk lua-aports git shadow patch doas \
    gcompat libaio libnsl libtirpc-dev patchelf

RUN adduser -u 1001 -G abuild -s /bin/sh -D ci && \
    addgroup ci wheel && \
    echo "permit nopass :wheel as root" > /etc/doas.d/doas.conf

# NOTE: Oracle Instant Client v19.8.0.0 requires libnsl.so.1. This library
# version is not available in Alpine >= v3. A simple workaround is to make a
# symbolic link from the current version to libnsl.so.1.
RUN ln -sn /usr/lib/libnsl.so.3 /usr/lib/libnsl.so.1

USER ci

WORKDIR /home/ci
COPY --chown=ci:abuild ./user/oracle-instantclient aports/user/oracle-instantclient
COPY --chown=ci:abuild packages_builder.sh .
RUN chmod +x packages_builder.sh

WORKDIR /home/ci/aports/user/oracle-instantclient
ENTRYPOINT ["sh", "/home/ci/packages_builder.sh"]
