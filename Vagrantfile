Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.33.33"
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell, inline: "ln -s /home/vagrant/sync /vagrant"
  config.vm.provision :shell, inline: "yum -y update"
  config.vm.provision :shell, inline: "yum -y install epel-release"
  config.vm.provision :shell, inline: "yum -y update"
  config.vm.provision :shell, inline: "yum -y install sudo vim git wget zsh postgresql postgresql-devel postgresql-server redis nginx gcc-c++ readline-devel openssh-clients openssl-devel libffi-devel zlib-devel nodejs npm"
  config.vm.provision :shell, inline: "systemctl enable redis"
  config.vm.provision :shell, inline: "systemctl enable postgresql"
  config.vm.provision :shell, inline: "systemctl disable firewalld"

  config.vm.provision :shell, path: "vagrant_provision/postgresql.sh"
  config.vm.provision :shell, path: "vagrant_provision/ruby.sh"

  config.vm.provision :shell, inline: "rbenv install 2.3.1 && rbenv global 2.3.1"
  config.vm.provision :shell, inline: "gem update --system && gem install bundler"

  config.vm.provision :shell, inline: "chmod -R 775 /usr/local/rbenv && chown -R vagrant:vagrant /usr/local/rbenv"

end
