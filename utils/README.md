# utils

## watch-change-vagrantfile.sh

- validate the Vagrantfile at save

- cd <DIRECTORY>/Vargrantfile

- ../utils/watch-change-vagrantfile.sh

## effective Vagrantfile
- sed -e '/\s*#.*$/d' -e '/^\s*$/d' Vagrantfile