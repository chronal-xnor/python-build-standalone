#!/usr/bin/env bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

set -ex

ROOT=`pwd`

export CC=clang
export CXX=clang++

tar -xf sqlite-autoconf-3280000.tar.gz
pushd sqlite-autoconf-3280000

CFLAGS="-fPIC" CPPFLAGS="-fPIC" ./configure --prefix /

make -j ${NUM_CPUS}
make -j ${NUM_CPUIS} install DESTDIR=${ROOT}/out
