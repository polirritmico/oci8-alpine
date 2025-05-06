FROM alpine:3.21

ENV BUILD_REPOS="user"

RUN apk add --no-cache alpine-sdk lua-aports git shadow patch doas \
    gcompat libaio libnsl libtirpc-dev patchelf


RUN adduser -u 1001 -G abuild -s /bin/sh -D ci && \
    addgroup ci wheel && \
    echo "permit nopass :wheel as root" > /etc/doas.d/doas.conf

# RUN install -d -o ci -m 777 /var/cache/distfiles
# RUN install -d -o ci -m 777 /home/ci/aports
# RUN install -d -o ci -m 777 /home/ci/.abuild
# RUN install -d -o ci -m 777 /home/ci/repos/alpine
#

USER ci
WORKDIR /home/ci/aports

# RUN git config --global --add safe.directory /home/ci/aports && \
#     sed -i "s/JOBS=[0-9]*/JOBS=$(nproc)/" /etc/abuild.conf
#
# RUN mkdir -p user/oracle-instantclient && \
#     chown -R ci:abuild user && \
#     chmod -R 775 user

COPY --chown=ci:abuild ./user/oracle-instantclient ./user/oracle-instantclient

# COPY --chown=ci:abuild build.sh /home/ci/build.sh
# RUN chmod +x /home/ci/build.sh

ENTRYPOINT ["sh"]

