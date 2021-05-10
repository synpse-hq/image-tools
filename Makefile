SHELL := /bin/bash

generate:
	source ./env && \
	envsubst <./assets/cloud-init/50-wifi.cfg.template> ./assets/cloud-init/50-wifi.cfg && \
	envsubst <./assets/cloud-init/60-synpse.cfg.template> ./assets/cloud-init/60-synpse.cfg

download-base:
	curl https://cdimage.ubuntu.com/releases/20.04.2/release/ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz?_ga=2.100551198.1484801762.1616928492-105156824.1616928492 -o assets/images/ubuntu-20.04.2.img.xz && \
	xz --decompress assets/images/ubuntu-20.04.2.img.xz

generate-image:
	sudo ./hack/bootstrap/bootstrap_ubuntu.sh
