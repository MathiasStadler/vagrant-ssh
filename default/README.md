# vagrant with ssh default setting

## effective Vagrantfile

```ruby
VM_NAME = "vagrant-ssh-default"
VAGRANT_BOX_NAME = "debian/stretch64"
VIRTUALBOX_MEMORY = "4096"
VIRTUALBOX_CPU = "4"
ENV["LC_ALL"] = "en_US.UTF-8"
VAGRANT_VERSION = "2.0.1"
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = VAGRANT_BOX_NAME
    config.vm.provider "virtualbox" do |vb|
        vb.name= VM_NAME
        vb.gui = false
        vb.memory = VIRTUALBOX_MEMORY
        vb.cpus = X
    end
end
```

## log output create own ssh kys

```bash
default: Vagrant insecure key detected. Vagrant will automatically replace
default: this with a newly generated keypair for better security.
default: Inserting generated public key within guest...
default: Removing insecure key from the guest if it's present...
default: Key inserted! Disconnecting and reconnecting using new SSH key
```