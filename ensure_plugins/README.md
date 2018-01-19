# during vagrant up ensure plugins

- [from here](https://github.com/hashicorp/vagrant/issues/1874)

## effective Vagrantfile

```ruby
VM_NAME = "vagrant-install-plugins"
VAGRANT_BOX_NAME = "debian/stretch64"
VIRTUALBOX_MEMORY = "4096"
VIRTUALBOX_CPU = "4"
ENV["LC_ALL"] = "en_US.UTF-8"
VAGRANT_VERSION = "2.0.1"
VAGRANTFILE_API_VERSION = "2"
plugins = ["vagrant-disksize",
"vagrant-vbguest",
"vagrant-scp",
"vagrant-proxyconf"]
puts plugins.length
def ensure_plugins(plugins)
    logger = Vagrant::UI::Colored.new
    result = false
    plugins.each do |p|
      pm = Vagrant::Plugin::Manager.new(
        Vagrant::Plugin::Manager.user_plugins_file
      )
      plugin_hash = pm.installed_plugins
      next if plugin_hash.has_key?(p)
      result = true
      pm.install_plugin(p)
    end
    if result
      logger.warn('Re-run vagrant up now that plugins are installed')
      exit
    else
      logger.info('Not additional plugins installed')
    end
  end
ensure_plugins(plugins)
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = VAGRANT_BOX_NAME
    config.vm.provider "virtualbox" do |vb|
        vb.name= VM_NAME
        vb.gui = false
        vb.memory = VIRTUALBOX_MEMORY
        vb.cpus = VIRTUALBOX_CPU
        end
  end
```
