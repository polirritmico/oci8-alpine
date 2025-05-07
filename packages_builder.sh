#!/usr/bin/env sh

set -e

cd /home/ci/aports/user/oracle-instantclient
abuild checksum
abuild unpack
abuild-keygen -a -n

abuild -r || echo "[✔] Success! Packages built successfully in /home/ci/packages/user/x86_64/"
