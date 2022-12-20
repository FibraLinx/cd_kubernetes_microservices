IMAGE_NAME = "ubuntu/focal64"
N = 2

Vagrant.configure(2) do |config|     

    config.vm.provision "file", source: "~/.ssh/vagrant_key.pub", destination: "/home/vagrant/.ssh/vagrant_key.pub"
    config.vm.provision :shell, :inline => "cat /home/vagrant/.ssh/vagrant_key.pub >> /home/vagrant/.ssh/authorized_keys", run: "always"

    # Configure master node  
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.56.10"
        master.vm.hostname = "k8s-master"
        master.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
        end
    end

    # Configure worker nodes
    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.56.#{i+10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provider "virtualbox" do |v|
                v.memory = 4096
                v.cpus = 2
            end
        end
    end

    # Configure jenkins 
    config.vm.define "jenkins" do |jenkins|
        jenkins.vm.box = IMAGE_NAME
        jenkins.vm.network "private_network", ip: "192.168.56.13"
        jenkins.vm.hostname = "jenkins"
        jenkins.vm.provider "virtualbox" do |v|
            v.memory = 2048
            v.cpus = 1
        end
    end
end
