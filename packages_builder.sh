#!/usr/bin/env sh

set -e

mkdir -p /home/ci/packages/user/x86_64

cd /home/ci/aports/user/oracle-instantclient

abuild checksum
abuild unpack
abuild-keygen -a -n
abuild -r || {
    cp /home/ci/packages/user/x86_64/* /home/ci/builds
    printf "\n-------------------------------------------------------------------------\n"
    printf "Success ✅.\nGenerated packages exported into the ./build directory.\n"
    printf "NOTE: The 'UNTRUSTED signature' and 'Failed to create index' errors are\n"
    printf "      expected in local builds.\n"
    printf "Install generated packages with --allow-untrusted if needed.\n"
}
