#!/usr/bin/env bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

set -ex

cd /build

export PATH=/tools/${TOOLCHAIN}/bin:/tools/host/bin:$PATH

tar -xf openssl-${OPENSSL_VERSION}.tar.gz

pushd openssl-${OPENSSL_VERSION}

# musl is missing support for various primitives.
# TODO disable secure memory is a bit scary. We should look into a proper
# workaround.
if [ "${CC}" = "musl-clang" ]; then
    EXTRA_FLAGS="no-async -DOPENSSL_NO_ASYNC -D__STDC_NO_ATOMICS__=1 no-engine -DOPENSSL_NO_SECURE_MEMORY "
fi

/usr/bin/perl ./Configure -shared --prefix=/build/out/tools/deps linux-x86_64 ${EXTRA_FLAGS}

make
make install
