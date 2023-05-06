#!/bin/sh -xe

BASE_DIR=/tmp/base/
NAME=$1
VERSION=$2
RELEASE=0
TOP_DIR=/tmp/rpmbuild
SRC_DIR=$TOP_DIR/SOURCES
mkdir -p $SRC_DIR

test -e "$SRC_DIR/qemu-${VERSION}.tar.xz" || wget -P $SRC_DIR "https://download.qemu.org/qemu-${VERSION}.tar.xz"

cd $BASE_DIR
rpmbuild --bb "${VERSION}-rpm.spec" \
	--define "_topdir ${TOP_DIR}" \
	--define "name ${NAME}" \
	--define "version ${VERSION}" \
	--define "release ${RELEASE}"

cp /tmp/pkg/rpm/RPMS/x86_64/* /opt/pkg/rpm/rocky/8/x86_64
