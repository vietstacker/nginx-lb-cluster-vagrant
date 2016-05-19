# Testing nginx loadbalancer in cluster with vagrant

## Instruction

1. Testing Architecture

- A virtual machine called LoadBalancer will be run as load balancer using nginx
- There are two virtual machines called Server1, Server2 (called AppNode) that are running a simple application as daemon using upstart

2. Software Usage

- On the host machine (physical machine), there is only vagrant dependency
- On the virtual machine, other tools/softwares will be installed due to the function of each machine.

3. File Contents

- roles: Including roles used for ansible
- appdeploy.sh: Bash file used in Vagrantfile shell provision for deploying a sample app on two AppNode
- appdeploy.yml: Yaml file for deploying sample app on two AppNodes, called by appdeploy.sh
- app.py: The source code of the sample app
- bootstrap.sh: Bash file used in Vagrantfile shell provision for deploying nginx on load balancer
- postinstall.sh: Bash file used in Vagrantfile shell provision to check the nginx port 80
- setup.yml: Yaml filee for deploying nginx on the load balancer
- Vagranfile: Includes two bash files for deploying app on two AppNode and another bash file for deploying nginx server on load balancer.

4. Execution flow

- On the load balancer:
-- Once this load balancer is successfully booted up, vagrant will trigger bootstrap.sh that is going to run as root user on that virtual host. The bootstrap.sh then runs ansible process with setup.yml that will install nginx and its configuration to be the load balancing of two others AppNodes cluster. Also the vagrant user of this host is also configured to run without password by using sudo.

-- The postinstall.sh is triggered by vagrant after nginx installed to check the port 80 is listened by nginx server.

- On the AppNode:
-- Once the AppNode is successfully booted up, vagrant will trigger appdeploy.sh. This bash script then runs appdeploy.yml by using ansible.

5. Usage

- Run "vagrant up" then everything will be ready. Take a coffee and relax.

6. Testing

- On the host, run "curl http://192.168.42.100:80" ( "192.168.42.100" is the eth1 of load balancer), the return value will switch between the return values of two servers based on round-robin setup of nginx.
- Note that the ip addresses of each node in this snippet should be changed to be suitable for the tester own environment.  

