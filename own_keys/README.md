# vagrant ssh with own keys

- We used the keys for login from $HOME/.ssh

## effective Vagrantfile

```ruby
VM_NAME = "vagrant-ssh-own-keys"
VAGRANT_BOX_NAME = "debian/stretch64"
VAGRANT_HOME_PATH = ENV["VAGRANT_HOME"] ||= "~/.vagrant.d"
VAGRANT_DOTFILE_PATH = ENV["VAGRANT_DOTFILE_PATH"] ||= "~/.vagrant.d"
VIRTUALBOX_MEMORY = "4096"
VIRTUALBO_CPU = "4"
ENV["LC_ALL"] = "en_US.UTF-8"
VAGRANT_VERSION = "2.0.1"
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = VAGRANT_BOX_NAME
    config.ssh.paranoid = true
    config.ssh.forward_agent = true
    config.ssh.insert_key = false
    config.vm.provider "virtualbox" do |vb|
        vb.name= VM_NAME
        vb.gui = false
        vb.memory = VIRTUALBOX_MEMORY
        vb.cpus = VIRTUALBO_CPU
        end
    config.vm.provision :shell, privileged: false do |shell_action|
        shell_action.inline = <<-SHELL
        SHELL
      end
  end
```

## log output create own ssh kys

```bash

```

## connect to vagrant vm wit own key

```bash
ssh vagrant@127.0.0.1 -p 2201
```

- The information for this command find you out with

```bash
> vagrant ssh-config
Host default
  HostName 127.0.0.1
  User vagrant
  Port 2201
  PasswordAuthentication no
  IdentityFile /home/trapapa/.vagrant.d/insecure_private_key
  IdentityFile /home/trapapa/.ssh/id_rsa
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardAgent yes
```


## sources

- [add user keys to vagrant](https://stackoverflow.com/questions/30075461/how-do-i-add-my-own-public-key-to-vagrant-vm)
- [vagrant ssh-info](https://stackoverflow.com/questions/28471542/cant-ssh-to-vagrant-vms-using-the-insecure-private-key-vagrant-1-7-2)