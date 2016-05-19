NODES = {
  :Server1  => { :ip => "192.168.42.15", :memory => 2048, :cpus => 2},
  :Server2  => { :ip => "192.168.42.16", :memory => 2048, :cpus => 2}
}

VAGRANTFILE_API_VERSION = "2"

PROVISION_SCRIPT ||= "bootstrap.sh"
NGINX_PORT_CHECK ||= "postinstall.sh"
APP_DEPLOY_SCRIPT ||= "appdeploy.sh"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  config.vm.box = "trusty64"
  config.vm.box_url = "https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm"

  NODES.each do |node_name, node_config|
    config.vm.define node_name do |node|
      node.vm.hostname = node_name

      # eth0: NAT network - is created by default by Vagrant
      # eth1: host-only network - to access the VM using its IP address
      node.vm.network :private_network, ip: node_config[:ip]

      node.vm.provider :virtualbox do |vb|
        vb.memory = node_config[:memory]
        vb.cpus = node_config[:cpus]
      end
      
      node.vm.provision :shell, path: APP_DEPLOY_SCRIPT
    end
  end

  config.vm.define "load_balancer" do |lb|
    lb.vm.hostname = "LoadBalancer"
    lb.vm.network :private_network, ip: "192.168.42.100"
    lb.vm.provision :shell, path: PROVISION_SCRIPT
    lb.vm.provision :shell, path: NGINX_PORT_CHECK
  end

end
