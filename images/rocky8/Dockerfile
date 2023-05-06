FROM rockylinux:8

RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf config-manager --set-enabled powertools

# install build tools for basic
RUN dnf -y install \
    curl wget git gcc gcc-c++ rpm-build createrepo python38 make ninja-build

# install build tools for qemu
RUN dnf -y install \
    glib2-devel pixman-devel zlib-devel libaio-devel libcap-devel libcap-ng-devel libiscsi-devel \
    jemalloc-devel numactl-devel libseccomp-devel libibumad-devel

CMD ["bash", "-c", "sleep 3600;"]
