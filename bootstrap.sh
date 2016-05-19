#!/bin/bash

# latest ansible

apt-get -y install software-properties-common

apt-add-repository ppa:ansible/ansible

apt-get -y update
apt-get -y install ansible


# Creates host file to ansible
#cat <<EOT >> /etc/ansible/hosts
#
#[nginx]
#192.168.42.12
#

#EOT


## Transfer ansible task to vagrant instance
#
#FILE=deploy_nginx.yml
#SERVER=localhost
#PATH=/home/vagrant
#
#OPTIONS=`vagrant ssh-config | grep -v '^Host ' | awk -v ORS=' ' 'NF{print "-o " $1 "=" $2}'`
#
#scp ${OPTIONS} $FILE vagrant@$SERVER:$PATH

# Runs ansible to deploy nginx
cd /vagrant
ansible-playbook setup.yml 

# Runs python app
#cd myApp/myapp 
#sudo python setup.py sdist
#sudo python setup.py install
#python app.py
