# utils

## watch-change-vagrantfile.sh

- validate the Vagrantfile at save

- cd VAGRANT_PROJECT_DIR/Vargrantfile

- ../utils/watch-change-vagrantfile.sh

## effective Vagrantfile

```bash
sed -e '/\s*#.*$/d' -e '/^\s*$/d' Vagrantfile
```