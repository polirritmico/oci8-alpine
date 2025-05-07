#!/usr/bin/env sh

set -e

mkdir -p /home/ci/packages/user/x86_64

cd /home/ci/aports/user/oracle-instantclient

abuild checksum
abuild unpack
abuild-keygen -a -n
abuild -r || {
    cp /home/ci/packages/user/x86_64/* /home/ci/builds
    echo -e "\n-------------------------------------------------------------------------"
    echo -e "Success ✅. Generated packages exported into the ./build directory."
    echo -e "NOTE: The 'UNTRUSTED signature' and 'Failed to create index' errors are"
    echo -e "      expected in local builds."
    echo -e "Install generated packages with --allow-untrusted if needed."
}
