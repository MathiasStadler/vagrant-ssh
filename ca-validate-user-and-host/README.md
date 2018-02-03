# vagrant ca-validate-user-and-host

## based on vagrant with ssh multi-machine-with-hostkey-verification

## Sources

 [SSH CA](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssh-ca-to-validate-hosts-and-clients-with-ubuntu)
- cd [ssh x509](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-using_openssh_certificate_authentication#sec-Introduction_to_SSH_Certificates)
(ansible ca)[https://www.tikalk.com/devops/Running-Your-Own-Ansible-Driven-CA/]


- Used a CA
 for validate user and host for login
## TL,DR

- set config to file ca-server-clients.yml
- export the config file

```bash
export VAGRANTS_HOST='ca-server-clients.yml'
```
- and start all VM with the command

```bash
vagrant up
```

- and with the commands see you the status 

```bash
> vagrant status
Current machine states:

primary                   running (virtualbox)
worker                    running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

- and ssh-config

```bash
> vagrant ssh-config
Host primary
  HostName 127.0.0.1
  User vagrant
  Port 2222
  PasswordAuthentication no
  IdentityFile /home/trapapa/Projects/ofGitHub/vagrant-ssh/multi-machine-with-hostkey-verification/.vagrant/machines/primary/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL

Host worker
  HostName 127.0.0.1
  User vagrant
  Port 2200
  PasswordAuthentication no
  IdentityFile /home/trapapa/Projects/ofGitHub/vagrant-ssh/multi-machine-with-hostkey-verification/.vagrant/machines/worker/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
```

## conditions

- [ ] No synced_folders between Host and VM and VM <-> VM 
- [ ] Not user public kez on server except one maintance kez
- [ ] No passwd login
- [ ] No root login
- [ ] CA kez always on ca-server 


- ![Alt pro](../signals_words/advantage.svg) All VM used a different key and host_key

- with setting
  - config.ssh.insert_key = true
  - config.ssh.paranoid = true

## effective Vagrantfile

```ruby
require 'yaml'
require 'open3'
require 'log4r'
logger = Log4r::Logger.new('vagrant::vagrantfile')
logger.debug 'enable logger debug'
logger.info 'enable logger info'
ENV['LC_ALL'] = 'en_US.UTF-8'
DEFAULT_BASE_BOX = 'none/none_set_default_box_name'.freeze
VAGRANTFILE_API_VERSION = '2'.freeze
VAGRANT_VERSION = '2.0.1'.freeze
PROJECT_NAME = '/' + File.basename(Dir.getwd)
PROJECT_HOME = Dir.getwd
USERDIR = Dir.home
FORCE_LOCAL_RUN = false
vagranthosts = ENV['VAGRANTS_HOST'] ? ENV['VAGRANTS_HOST'] : 'vagrant-hosts.yml'
hosts = YAML.load_file(File.join(__dir__, vagranthosts))
def provision_ansible(config, host)
  if run_locally?
    config.vm.provision 'shell' do |sh|
      sh.path = 'scripts/run-playbook-locally.sh'
    end
  else
    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = host.key?('playbook') ?
          'ansible/site.yml'
      ansible.become = true
    end
  end
end
def run_locally?
  windows_host? || FORCE_LOCAL_RUN
end
def windows_host?
  Vagrant::Util::Platform.windows?
end
def network_options(host)
  options = {}
  if host.key?('ip')
    options[:ip] = host['ip']
    options[:netmask] = host['netmask'] ||= '255.255.255.0'
  else
    options[:type] = 'dhcp'
  end
  options[:mac] = host['mac'].gsub(/[-:]/, '') if host.key?('mac')
  options[:auto_config] = host['auto_config'] if host.key?('auto_config')
  options[:virtualbox__intnet] = true if host.key?('intnet') && host['intnet']
  options
end
def custom_synced_folders(vm, host)
  return unless host.key?('synced_folders')
  folders = host['synced_folders']
  folders.each do |folder|
    vm.synced_folder folder['src'], folder['dest'], folder['options']
  end
end
def shell_provisioners_always(vm, host)
  if host.key?('shell_always')
    scripts = host['shell_always']
    scripts.each do |script|
      vm.provision 'shell', inline: script['cmd'], run: 'always'
    end
  end
end
def forwarded_ports(vm, host)
  if host.key?('forwarded_ports')
    ports = host['forwarded_ports']
    ports.each do |port|
      vm.network 'forwarded_port', guest: port['guest'], host: port['host']
    end
  end
end
def self.copy_file(src, dest)
  File.open(dest, 'w') { |f| f.write(File.read(src)) }
end
def remove_kez_added_by_vagrant(host, known_hosts, logger)
  if File.exist?(known_hosts_add_by_vagrant)
    File.open(known_hosts_add_by_vagrant, 'r') do |file_handle|
      file_handle.each_line do |server_kez|
        if server_kez.empty?
          logger.warn 'Please remove by hand'
        else
          server_kez = server_kez.gsub!('|', '\\|')
          server_kez = server_kez.gsub!('/', '\\/')
          Open3.popen3(command) do |_stdin, stdout, stderr, _thread|
          end
        end
      end
    end
    FileUtils.remove_file(known_hosts_add_by_vagrant, force = false)
  else
  end
end
def set_keys_to_known_host(host, known_hosts, logger)
  forwarding_port = forwarding_port_plain.split(',')[3]
  open(known_hosts.to_s, 'a+') do |file_handler|
    file_handler << kez.to_s
  end
    file_handler << kez.to_s
  end
end
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = true
  config.ssh.paranoid = true
  hosts.each do |host|
    [:up].each do |cmd|
      config.trigger.after cmd, stdout: true, force: true, vm: host['name'] do
        set_keys_to_known_host(host, known_hosts, logger)
      end
    end
    %i[destroy].each do |cmd|
      config.trigger.after cmd, stdout: true, force: true, vm: host['name'] do
        remove_kez_added_by_vagrant(host, known_hosts, logger)
      end
    end
    config.vm.define host['name'] do |node|
      node.vm.box = host['box'] ||= DEFAULT_BASE_BOX
      node.vm.box_url = host['box_url'] if host.key? 'box_url'
      node.vm.hostname = host['name']
      node.vm.network :private_network, network_options(host)
      config.vm.synced_folder '.', '/vagrant', disabled: true
      node.vm.provider :virtualbox do |vb|
        vb.customize ['modifyvm', :id, '--groups', PROJECT_NAME]
      end
    end
  end
end
```

## log output with insecure_private_key

- The insecure_private_key is stored in $HOME/.vagrant.d/insecure_private_key

```bash
#TODO missing
```

