#!/usr/bin/env sh

set -e

apk update || true

cd /home/ci/aports

# generate and manually install rsa keys
su ci sh -c "abuild-keygen -a -n"
cp /home/ci/.abuild/ci-*.pub /etc/apk/keys/

mkdir -p /home/ci/repos/alpine/user
su root sh -c "chmod 777 -R /home/ci/repos/alpine/user"
exec su ci sh -c "buildrepo -d /home/ci/repos/alpine user oracle-instantclient"
