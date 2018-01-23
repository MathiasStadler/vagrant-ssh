# vagrant-ssh

- apply OpenSSH with vagrant

## Which ssh version used vagrant

- vagrant used the ssh version that found at first in the environment PATH

## How to set a different ssh version

- Put the path of different SSH versoin at first in your PATH variable

## Print version of ssh command

```bash
> ssh -V
OpenSSH_7.2p2 Ubuntu-4ubuntu2.4, OpenSSL 1.0.2g  1 Mar 2016
```

## default - SAFE

- used the keys from .vagrant/machines/default/virtualbox/private_key
  - create for each VM box during the vagrant up phase

## ssh insecure key - NOT SAFE

- use vagrant out of the box but with with insecure key
  - equal keypair for each VM

```bash
config.ssh.insert_key = false
```

## ssh own_keys - NOT SAFE

- used the keys from $HOME/.ssh for login on the linux based box
- used the keys from $HOME/.vagrant.d/insecure_private_key

## ssh own-keys-without-insecure-keys - SAFE

- used the keys from $HOME/.ssh for login on the linux based box
- used the keys from .vagrant/machines/default/virtualbox/private_key
  - create for each VM box during the vagrant up phase

## ssh with crt from CA

@TODO/Mathias

## ensure-plugins

- install plugins function (ruby def) inside Vagrantfile

## vagrant log output

```bash
VAGRANT_LOG=info vagrant up 2>&1| tee /tmp/vagrant.log
```

## sources

[Change Insecure Key To My Own Key On Vagrant](http://ermaker.github.io/blog/2015/11/18/change-insecure-key-to-my-own-key-on-vagrant.html)
