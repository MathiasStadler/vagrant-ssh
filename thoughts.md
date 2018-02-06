<!-- markdownlint-disable -->
/* spell-checker: disable */

The place for brain waste

https://swarm.workshop.perforce.com/view/guest/jen_bottom/vagrant/Vagrantfile?v=85


vb.customize ["modifyvm", :id, "--ioapic", "on"]



VAGRANT_CHECKPOINT_DISABLE 
https://www.vagrantup.com/docs/other/environmental-variables.html


VAGRANT_BOX_UPDATE_CHECK_DISABLE
https://www.vagrantup.com/docs/other/environmental-variables.html

plugins
vagrant plugin install vagrant-timezone
vagrant plugin install vagrant-digitalocean

https://www.vagrantup.com/docs/multi-machine/

https://github.com/williambailey/vagrant-ca-certificates

http://ishan.co/ssl-vagrant-local

https://books.google.de/books?id=7YJcDgAAQBAJ&pg=PA365&lpg=PA365&dq=vagrant+setup+ca&source=bl&ots=J0aDBI3zmL&sig=pEVthYCwec51r93n1cKRBwWrBMw&hl=de&sa=X&ved=0ahUKEwisl_DCy-fYAhXCy6QKHdDtBkgQ6AEIYzAG#v=onepage&q=vagrant%20setup%20ca&f=false


https://books.google.de/books?id=5AtnCgAAQBAJ&pg=PA125&lpg=PA125&dq=vagrant+setup+ca&source=bl&ots=msKgpIc_S7&sig=JPXbeiwTm6GgjNTBtJGfusvtjcs&hl=de&sa=X&ved=0ahUKEwisl_DCy-fYAhXCy6QKHdDtBkgQ6AEIXDAF#v=onepage&q=vagrant%20setup%20ca&f=false


```ruby
PROJECT_NAME = '/' + File.basename(Dir.getwd)
```
smalltest box
Vagrant.configure("2") do |config|
  config.vm.box = "olbat/tiny-core-micro"
  config.vm.box_version = "0.1.0"
end


## force ssh chipher 
- client side
- server side

# force tls version
- server side


#
- ssh-keyscan -t rsa -p 2222 localhost

- see here
https://security.stackexchange.com/questions/119044/public-key-for-ssh-over-the-internet-differs-from-a-key-for-ssh-over-the-lan


ssh-keyscan  -t ecdsa-sha2-nistp256 -H  -p 2222 127.0.0.1



## ruby linter

https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby


// Basic settings: turn linter(s) on
"ruby.lint": {
	"reek": true,
	"rubocop": true,
	"ruby": true, //Runs ruby -wc
	"fasterer": true,
	"debride": true,
	"ruby-lint": true
}

//advanced: set command line options for some linters:
"ruby.lint": {
	"ruby": {
		"unicode": true //Runs ruby -wc -Ku
	},
	"rubocop": {
		"only": ["SpaceInsideBlockBraces", "LeadingCommentSpace"],
		"lint": true,
		"rails": true
	},
	"reek": true
}

# rules config
https://github.com/bbatsov/rubocop/tree/master/config

# ruby style guide
https://github.com/bbatsov/ruby-style-guide#80-character-limits

# # Thanks to @jnt30 for the comment!
method(argument) # rubocop:disable SomeRule, SomeOtherRule

2002  2018-01-27 22:13:45 sudo gem install rubocop
 2003  2018-01-27 22:15:35 sudo gem install ruby-lint
 2004  2018-01-27 22:16:50 gem install fasterer
 2005  2018-01-27 22:16:57 sudo gem install fasterer
 2006  2018-01-27 22:18:18 gem install debride
 2007  2018-01-27 22:18:25 sudo gem install debride
 2008  2018-01-27 22:20:00 sudo gem install reek


## vagrant plugin install vagrant-triggers
- from here
- https://github.com/emyl/vagrant-triggers



- from here 
- https://github.com/hashicorp/vagrant/issues/5199

config.trigger.before [:reload, :up, :provision], stdout: true do
  SYNCED_FOLDER = ".vagrant/machines/default/virtualbox/synced_folders"
  info "Trying to delete folder #{SYNCED_FOLDER}"
  # system "rm #{SYNCED_FOLDER}"
  begin
    File.delete(SYNCED_FOLDER)
  rescue Exception => ex
    warn "Could not delete folder #{SYNCED_FOLDER}."
    warn ex.message
  end
end


## missing pluguns
# Require the Trigger plugin for Vagrant
unless Vagrant.has_plugin?('vagrant-triggers')
  # Attempt to install ourself. 
  # Bail out on failure so we don't get stuck in an infinite loop.
  system('vagrant plugin install vagrant-triggers') || exit!

  # Relaunch Vagrant so the new plugin(s) are detected.
  # Exit with the same status code.
  exit system('vagrant', *ARGV)
end

- in short
unless Vagrant.has_plugin?("vagrant-triggers")
    raise 'vagrant-triggers plugin needs to be installed: vagrant plugin install vagrant-triggers'
  end


## register trigger for spezial vm
- from here
- https://github.com/emyl/vagrant-triggers/issues/28


config.trigger.after :destroy, :stdout => true, :force => true, :vm => "web" do
  info "Removing provisioned directory contents: #{host_provisioned_dir}/*"
  FileUtils.rm_rf Dir.glob("#{host_provisioned_dir}/*")
end

FileUtils.remove_file(path, force = false)


## check VM not created. Moving on...



## bindfs
https://github.com/gael-ian/vagrant-bindfs/blob/master/Vagrantfile


## INFO proxyconf: git_proxy not enabled or configured


$ PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ANSIBLE_HOST_KEY_CHECKING=false ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=60s' ansible-playbook --private-key=/home/someone/.vagrant.d/insecure_private_key --user=vagrant --connection=ssh --limit='machine1' --inventory-file=/home/someone/coding-in-a-project/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml


/opt/vagrant/embedded/gems/gems/vagrant-2.0.1/plugins/provisioners/ansible/provisioner


[robots]
jenkins ansible_ssh_host=127.0.0.1 ansible_ssh_port=2222 ansible_ssh_user='vagrant' ansible_ssh_private_key_file='/home/trapapa/.vagrant.d/insecure_private_key'


## Go ahead and give a try and tell me what you think (open an issue if needed ;)) 
<!-- markdownlint-enable -->
/* spell-checker: enable */
