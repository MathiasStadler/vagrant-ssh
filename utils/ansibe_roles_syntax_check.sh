#!/bin/bash

err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

usage() {
    
    echo -e "Usage: "
    echo -e " $(basename "$0") file.yml inventory "
}


# fro  here
# https://stackoverflow.com/questions/4665051/check-if-passed-argument-is-file-or-directory-in-bash
check_inventory_file(){
file="${1}"
result="$(file "$file")"
if [[ $result == *"cannot open"* ]] ;then
        echo "NO FILE FOUND ($result) ";
        return 1
elif [[ $result == *"directory"* ]] ;then
        echo "directory found => ($result) ";
        echo " Please give me a file not a directory"
else
        echo "file found => ($result) ";
        echo "a Inventory file found"
fi

}



# from here
# https://liquidat.wordpress.com/2016/01/21/short-tip-verify-yaml-in-shell-via-python-one-liner/
check_yml() {

    set +x # make sure the command echos
    output=$(python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' <"${1}" >/dev/null)
    result="$?"
    set +x # undo command echoing
    if [ "$result" -ne 0 ]; then
        echo -e "\033[01;33;41mOught please fix your YAML File\033[0m"
    else
        echo -e "Your YAML File looks ok $result"
    fi
}

check_ansible() {

    playbook_file="${1}"
    ansible_inventory_file="${2}"

    set +x # make sure the command echos
    output=$(/usr/bin/ansible-playbook --syntax-check --check -i "${ansible_inventory_file}" "${path_of_test_yml}")
    result="$?"
    set +x # undo command echoing
    if [ "$result" -ne 0 ]; then
        echo -e "\033[01;33;41mOught please fix your YAML File\033[0m"

    else
        echo -e "Your YAML File looks ok $result"
    fi

}

check_ansible_roles () {

playbook_file="${1}"
ansible_inventory_file="${2}"


# found root roles dir
#/home/trapapa/Projects/ofGitHub/vagrant-ssh/ca-validate-user-and-host/provisioning/ansible/roles/ca-server/tasks/ca-conf.yml

# from here
# https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash
path_items=(${playbook_file//\// })



#readarray -td, path_items <<<"${path},"; declare -p path_items;
# from here
# https://stackoverflow.com/questions/10586153/split-string-into-an-array-in-bash
#readarray -t path_items <<<"${path}"

# path_items=()
# while [[ $path =~ ([^,]+)(/[ ]+|$) ]]; do
#     array+=("${BASH_REMATCH[1]}")   # capture the field
#     i=${#BASH_REMATCH}              # length of field + delimiter
#     str=${str:i}                    # advance the string by that length
# done                                # the loop deletes $str, so make a copy if needed

# declare -p path_items




#echo "path_items ${path_items[@]}"
echo "path_items $*{path_items}"

position_count=0;
path_of_roles=""
for i in "${path_items[@]}"
do

path_of_roles="${path_of_roles}/${i}"
    if [ "$i" == "roles" ] ; then
        echo "Found ${i}"
        echo "${position_count}"
        pos_of_match=${position_count}
    break
    fi

    

    (( position_count++ ))
done

echo "path_of_roles ${path_of_roles}"

echo "pos_of_match => ${pos_of_match}"

echo "ansible role => ${path_items[${pos_of_match}+1]}"

role_name=${path_items[${pos_of_match}+1]}

test_yml_path="${role_name}/tests/main.yml"


echo "test_yml_path ${test_yml_path}"


path_of_test_yml="${path_of_roles}/${test_yml_path}"

echo "path_of_test_yml ${path_of_test_yml}"

cmd="/usr/bin/ansible-playbook --syntax-check --check -i "${ansible_inventory_file}" "${path_of_test_yml}" "

# from here
# https://www.cyberciti.biz/tips/shell-scripting-bash-how-to-create-temporary-random-file-name.html
tmp_cmd_file="$(mktemp /tmp/run-ansible-playbook-check.XXXXXX)"

echo $cmd > ${tmp_cmd_file}

chmod +x ${tmp_cmd_file}

output=$("${tmp_cmd_file}")

result="$?"
    set +x # undo command echoing
    if [ "$result" -ne 0 ]; then
        echo -e "\033[01;33;41mOught please fix your YAML File\033[0m"
    else
        echo -e "Your YAML File looks ok $result"
    fi

}

# from here
# https://stackoverflow.com/questions/4665051/check-if-passed-argument-is-file-or-directory-in-bash
check_ansible_file() {
    

playbook_file="${1}"
ansible_inventory_file="${2}"

    result=$(file "$playbook_file")
    if [[ $result == *"cannot open"* ]]; then
        echo "NO FILE FOUND ($result) "
        exit 1
    elif [[ $result == *"directory"* ]]; then
        echo "DIRECTORY FOUND ($result) "
    else
        echo "FILE FOUND ($result) "
        if [[ $playbook_file =~ .*ansible.*roles.*yml ]]; then
            echo "ansible roles found"
            check_yml "${playbook_file}"
            check_ansible_roles "${playbook_file}" "${ansible_inventory_file}"
        elif [[ $playbook_file =~ .*ansible.*yml ]]; then
            echo "ansible found"
            check_yml "${playbook_file}"
            check_ansible "${playbook_file}" "${ansible_inventory_file}"
        elif [[ $playbook_file =~ .*yml ]]; then
            echo " NO ansible and roles found"
            check_yml "${playbook_file}"
        else

            echo "No YAML File"
            return 0 

        fi
    fi

}

playbook_file="${1}"
ansible_inventory_file="${2}"



if [ -z "${1}" ]; then
        echo "Missing file"
        exit 1
        
    fi

    if [ -z "${2}" ]; then
        echo "Missing inventory"
        echo " Check YAML syntax only"
        check_yml "${playbook_file}"
        
    else
        echo "check ...."
        check_inventory_file "${ansible_inventory_file}"
        check_ansible_file "${playbook_file}" "${ansible_inventory_file}"
    fi

echo "Ciao ..."    

exit 0

#check_ansible_file "${1}"

# we expect the file has the path
# */*yml
# */ansible/*yml
# or
# */ansible/roles/*yml
# yml w/o ansible => yml check only
# yml w/ansible => ansible check
# yml w/ansible and w/roles  and w/test directory
# -> check link to role
# -> test/main.yml available
# -> check role in main.yml
# => ansible roles check
#
