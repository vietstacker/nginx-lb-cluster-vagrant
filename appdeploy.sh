#!/bin/bash

# Install latest ansible

apt-get -y install software-properties-common

apt-add-repository ppa:ansible/ansible

apt-get -y update
apt-get -y install ansible

# Install Flask
apt-get -y install python-pip
pip install Flask

# Deploy app
cd /vagrant
ansible-playbook appdeploy.yml


