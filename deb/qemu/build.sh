#!/bin/sh -xe

NAME=$1
VERSION=$2
OS_RELEASE=$3
RELEASE=0
WORK_DIR=/tmp/work
PKG_DIR=$WORK_DIR/pkg
DEB_DIR=$PKG_DIR/DEBIAN

mkdir -p $DEB_DIR
cd $WORK_DIR

apt-get update
apt-get install -y ninja-build pkg-config \
	zlib1g-dev librdmacm-dev libibverbs-dev libvde-dev libvdeplug-dev \
	libcap-ng-dev libglib2.0-dev libpixman-1-dev libaio-dev libnuma-dev \
	libjemalloc-dev libiscsi-dev libibumad-dev libseccomp-dev

test -e "qemu-${VERSION}.tar.xz" || wget "https://download.qemu.org/qemu-${VERSION}.tar.xz"
tar xf "qemu-${VERSION}.tar.xz"
cd "qemu-${VERSION}"

./configure --enable-vnc --enable-kvm \
	--enable-coroutine-pool \
	--enable-numa --enable-jemalloc \
	--enable-linux-aio --enable-libiscsi --enable-rdma \
	--enable-vhost-net \
	--enable-seccomp --enable-cap-ng --enable-tpm \
	--enable-pie --disable-mpath --disable-strip \
	--prefix=/usr

make -j16
make install DESTDIR=${PKG_DIR}

# make control
cat <<EOS >${DEB_DIR}/control
Package: ${NAME}
Maintainer: Kitada Shyunya <syun.kitada@gmail.com>
Architecture: amd64
Version: ${VERSION}-${RELEASE}
Description: ${NAME}
EOS

# build deb
cd $WORK_DIR
fakeroot dpkg-deb --build $PKG_DIR .

cd $WORK_DIR
cp *.deb "/opt/pkg/deb/ubuntu/${OS_RELEASE}/amd64/pool"
