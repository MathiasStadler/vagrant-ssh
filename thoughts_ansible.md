<!-- markdownlint-disable -->
/* spell-checker: disable */

## version
ansible --version

## A list of all installed modules is also available:

```bash
ansible-doc -l
```

## jinja2 tempalte language for ansible in python
- http://jinja.pocoo.org/docs/2.10/

## ansible localhost -m setup
python -c "import platform; print(platform.system());"

result Plattform => Linux

## Check Mode (“Dry Run”)
```bash
ansible-playbook foo.yml --check
```

## ci test
https://raymii.org/s/tutorials/Ansible_-_Playbook_Testing.html


## https://github.com/nickjj/rolespec

## https://docs.debops.org/en/latest/


## test travis
- https://www.jeffgeerling.com/blog/testing-ansible-roles-travis-ci-github

## test of multiplatforms
- https://molecule.readthedocs.io/en/latest/usage.html

## test multiversion of ansible
- https://tasdikrahman.me/2017/04/06/Testing-your-ansible-roles-using-travis-CI/


## https://www.ansible.com/blog/testing-ansible-roles-with-docker


## https://github.com/chrismeyersfsu/provision_docker
- many samples and link

<!-- markdownlint-enable -->
/* spell-checker: enable */