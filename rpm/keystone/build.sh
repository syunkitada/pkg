#!/bin/sh -xe

BASE_DIR=/tmp/base/
NAME=$1
VERSION_NAME=$2
VERSION=$3
RELEASE=$(date +"%Y%m%d")
TOP_DIR=/tmp/rpmbuild
SRC_DIR=$TOP_DIR/SOURCES
mkdir -p $SRC_DIR

cd $BASE_DIR/../
tar -cf $SRC_DIR/base.tar.gz base

rpmbuild --bb "base/${VERSION_NAME}-rpm.spec" \
	--define "_topdir ${TOP_DIR}" \
	--define "name ${NAME}" \
	--define "version_name ${VERSION_NAME}" \
	--define "version ${VERSION}" \
	--define "release ${RELEASE}"

cp /tmp/rpmbuild/RPMS/x86_64/* /opt/pkg/rpm/rocky/8/x86_64
