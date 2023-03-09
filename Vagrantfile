Vagrant.configure("2") do |config|
  
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true
  config.vm.boot_timeout = 900

  config.vm.define "kube-start" do |server|
    server.vm.box = "geerlingguy/ubuntu2004"
    server.vm.hostname = "kube"  
    server.vm.network "public_network", ip: "192.168.0.18"

  # default router
    server.vm.provision "shell",
    run: "always",
    inline: "route add default gw 192.168.0.1"

  # delete default gw on eth0
    server.vm.provision "shell",
    run: "always",
    inline: "eval `route -n | awk '{ if ($8 ==\"eth0\" && $2 != \"0.0.0.0\") print \"route del default gw \" $2; }'`"

    server.vm.provider "virtualbox" do |vb|
      vb.memory = "8192"
      vb.name = "kube-start"
      vb.cpus = "8"
	end
  #server.vm.provision "shell", path: "data/*.sh"
	end
end
