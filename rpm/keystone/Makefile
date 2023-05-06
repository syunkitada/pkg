8-x86_64-bash:
	sudo docker run --rm -it \
	-v ${PWD}:/tmp/base -v /opt/pkg/rpm/rocky/8/x86_64:/opt/pkg/rpm/rocky/8/x86_64 \
	pkgbuilder/rocky8:latest bash

8-x86_64-antelope:
	sudo docker run --rm -it \
	-v ${PWD}:/tmp/base -v /opt/pkg/rpm/rocky/8/x86_64:/opt/pkg/rpm/rocky/8/x86_64 \
	pkgbuilder/rocky8:latest /tmp/base/build.sh keystone antelope 23.0.0
