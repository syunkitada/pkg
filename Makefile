images:
	@make docker-image-rocky8
	@make docker-image-ubuntu22

docker-image-rocky8:
	sudo docker build -t pkgbuilder/rocky8 ./images/rocky8

docker-image-ubuntu22:
	sudo docker build -t pkgbuilder/ubuntu22 ./images/ubuntu22

start:
	sudo docker run -d --rm --net=host -v ./etc/nginx/conf.d:/etc/nginx/conf.d -v /opt/pkg:/opt/pkg --name pkg nginx:latest

stop:
	sudo docker stop pkg

restart:
	@make stop
	@make start

repo:
	cd /opt/pkg/deb/ubuntu/22/amd64/ && sudo sh -c 'apt-ftparchive packages pool | gzip | dd of=Packages.gz bs=1M'
	sudo createrepo_c /opt/pkg/rpm/rocky/8/x86_64/

env:
	sudo apt-get install createrepo-c
