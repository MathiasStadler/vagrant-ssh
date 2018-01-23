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

<!-- markdownlint-enable -->
/* spell-checker: enable */
