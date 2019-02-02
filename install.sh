#!/bin/bash -l

DOCKER_DOWNLOAD_URL="https://download.docker.com/linux"
DOCKER_CHANNEL="stable"
DOCKER_REPO_FILE="docker-ce.repo"
DOCKER_COMPOSE_DOWNLOAD_URL="https://github.com/docker/compose/releases/download"
DOCKER_COMPOSE_VERSION="1.23.2"

get-distribution() {
	if [ -r /etc/os-release ]; then
		. /etc/os-release && echo "$ID"
	fi
}

get-distribution-version() {
	case $(get-distribution) in
		ubuntu)
			. /etc/os-release && echo "$VERSION_CODENAME"
		;;
		centos)
			. /etc/os-release && echo "$VERSION_ID"
		;;
	esac
}

install-requirements() {
	case $(get-distribution) in
		ubuntu)
			sudo apt-get update -y
			sudo apt-get install -y apt-transport-https \
				git \
				ca-certificates curl \
				gnupg-agent	\
				software-properties-common
			sudo curl -fsSL $DOCKER_DOWNLOAD_URL/$(get-distribution)/gpg | sudo apt-key add -
			sudo add-apt-repository \
				"deb [arch=$(dpkg --print-architecture)] $DOCKER_DOWNLOAD_URL/$(get-distribution) \
				$(get-distribution-version) \
				$DOCKER_CHANNEL"
			sudo apt-get update -y
		;;
		centos)
			yum_repo=$DOCKER_DOWNLOAD_URL/$(get-distribution)/$DOCKER_REPO_FILE
			sudo yum install -y yum-utils \
				device-mapper-persistent-data \
				git \
				lvm2
			sudo yum-config-manager \
				--add-repo \
				$yum_repo
		;;
	esac
}

add-current-user-to-docker-group(){
	sudo groupadd -f docker
	sudo usermod -aG docker $USER
	. ~/.bashrc
}

install-docker() {
	case $(get-distribution) in
		ubuntu)
			sudo apt-get install -y docker-ce docker-ce-cli containerd.io
		;;
		centos)
			sudo yum install -y docker-ce docker-ce-cli containerd.io
			sudo systemctl enable docker
			sudo systemctl start docker
		;;
	esac
	add-current-user-to-docker-group
}

install-docker-compose() {
	sudo curl -L "$DOCKER_COMPOSE_DOWNLOAD_URL/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

start-vpnvilling() {
	sudo docker-compose up
}

main() {
	if ! [ -x "$(command -v docker)" ]; then
		install-requirements
		install-docker
		install-docker-compose
	fi
	start-vpnvilling
}

main
