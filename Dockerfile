FROM alpine:3.21

ENV BUILD_REPOS="user"

RUN apk add --no-cache alpine-sdk lua-aports git shadow patch doas \
    gcompat libaio libnsl libtirpc-dev patchelf

RUN adduser -u 1001 -G abuild -s /bin/sh -D ci && \
    addgroup ci wheel && \
    echo "permit nopass :wheel as root" > /etc/doas.d/doas.conf

# NOTE: Oracle Instant Client v19.8.0.0 requires libnsl.so.1. This library is
# not available in Alpine Linux repositories for versions ≥ v3. If needed, you
# may try installing a pre-Alpine v3 libnsl package.
RUN ln -sn /usr/lib/libnsl.so.3 /usr/lib/libnsl.so.1

USER ci

WORKDIR /home/ci
COPY --chown=ci:abuild ./user/oracle-instantclient aports/user/oracle-instantclient
COPY --chown=ci:abuild build.sh .
RUN chmod +x build.sh

WORKDIR /home/ci/aports/user/oracle-instantclient
ENTRYPOINT ["sh", "/home/ci/build.sh"]
