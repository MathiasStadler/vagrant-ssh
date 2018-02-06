<!-- markdownlint-disable -->
/* spell-checker: disable */

## jinja2 tempalte language for ansible in python
- http://jinja.pocoo.org/docs/2.10/

## ansible localhost -m setup
python -c "import platform; print(platform.system());"

result Plattform => Linux

## Check Mode (“Dry Run”)
```bash
ansible-playbook foo.yml --check
```

<!-- markdownlint-enable -->
/* spell-checker: enable */