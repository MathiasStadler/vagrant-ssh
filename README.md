# vagrant-ssh

- apply OpenSSH with vagrant

## default

- use vagrant out of the box

## ssh insecure key

- use vagrant out of the box but with with insecure key

```bash
config.ssh.insert_key = false
```

## ssh own keys

@TODO/Mathias

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
