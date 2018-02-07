#!/bin/bash


# from here
# https://stackoverflow.com/questions/4665051/check-if-passed-argument-is-file-or-directory-in-bash

check_file(){

if [ -z "${1}" ] ;then
 echo "Please input something"
 return;
fi

f="${1}"
result="$(file $f)"
if [[ $result == *"cannot open"* ]] ;then
        echo "NO FILE FOUND ($result) ";
elif [[ $result == *"directory"* ]] ;then
        echo "DIRECTORY FOUND ($result) ";
else
        echo "FILE FOUND ($result) ";
fi

}

check_file ${1}

# yml w/o ansible => yml check only
# yml w/ansible => ansible check
# yml w/ansible and w/roles  and w/test directory
    # -> check link to role
    # -> test/main.yml avaible
    # -> check role in main.yml
    # => ansible roles check
    # 