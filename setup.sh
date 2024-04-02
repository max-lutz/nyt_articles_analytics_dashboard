#!/bin/bash

#install terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# install docker
sudo apt-get install docker.io

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


export GOOGLE_APPLICATION_CREDENTIALS=~/nyt_project.json
gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker


# check that everything is installed
terraform --version
docker --version
docker-compose --version