# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {
	"node00" => "192.168.22.10"
}
$script = <<SCRIPT
cat > /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
192.168.22.10 node00
EOF

SCRIPT

Vagrant.configure("2") do |config|
  hosts.each do |name, ip|
    config.vm.define name do |machine|
      machine.vm.box = "bento/centos-7.6"
      machine.vm.box_check_update = false
      machine.ssh.insert_key = false
      machine.vm.hostname = name
      machine.vm.network :private_network, ip: ip
      machine.vm.provision "shell", inline: $script
      machine.vm.provision :ansible do |ansible|
        ansible.compatibility_mode = "2.0"
        ansible.playbook = "all.yml"
        ansible.inventory_path = "environments/local/hosts"
        ansible.become = true
      end
      machine.vm.provider "virtualbox" do |v|
          v.name = name
          v.customize ["modifyvm", :id, "--memory", 2048]
          v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          v.customize ["modifyvm", :id, "--ioapic", "on"]
       end
    end
  end
end
