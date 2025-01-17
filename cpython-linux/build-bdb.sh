#!/usr/bin/env bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

set -ex

cd /build

export PATH=/tools/${TOOLCHAIN}/bin:/tools/host/bin:$PATH

tar -xf db-${BDB_VERSION}.tar.gz

pushd db-${BDB_VERSION}/build_unix

CLFAGS="${EXTRA_TARGET_CFLAGS} -fPIC" CPPFLAGS="${EXTRA_TARGET_CFLAGS} -fPIC" ../dist/configure \
    --build=x86_64-unknown-linux-gnu \
    --target=${TARGET} \
    --prefix=/tools/deps \
    --enable-dbm \
    --disable-shared

make -j `nproc`
make -j `nproc` install DESTDIR=/build/out
