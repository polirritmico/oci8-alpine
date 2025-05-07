#!/usr/bin/env sh

set -e

cd /home/ci/aports/user/oracle-instantclient
abuild checksum
abuild unpack
abuild-keygen -a -n

abuild -r || {
    echo -e "\n-------------------------------------------------------------------------"
    echo "Check /home/ci/packages/user/x86_64/ for the generated packages."
    echo -e "Note: The 'UNTRUSTED signature' warning is expected for local builds.\nInstall packages with --allow-untrusted if needed."
}
