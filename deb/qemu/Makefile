22-amd64-bash:
	sudo docker run --rm -it \
		-v ${PWD}:/tmp/base -v /opt/pkg/deb/ubuntu/22/amd64/pool:/opt/pkg/deb/ubuntu/22/amd64/pool \
		pkgbuilder/ubuntu22:latest bash

22-amd64-7.2.1:
	sudo docker run --rm \
		-v ${PWD}:/tmp/base -v /opt/pkg/deb/ubuntu/22/amd64/pool:/opt/pkg/deb/ubuntu/22/amd64/pool \
		pkgbuilder/ubuntu22:latest /tmp/base/build.sh qemu 7.2.1 22
