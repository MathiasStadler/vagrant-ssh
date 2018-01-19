#!/bin/bash

# from here
# https://serverfault.com/questions/1669/shell-command-to-monitor-changes-in-a-file-whats-it-called-again/1670

PACKAGE_NAME="inotify-tools"

if [ "$(dpkg-query -W -f='${Status}' "${PACKAGE_NAME}"  2>/dev/null | grep -c "ok installed")" -eq 0 ];
then
    sudo apt install "${PACKAGE_NAME}";
else
    echo "${PACKAGE_NAME} already installed"
fi


# -m monitor
# -e event 
inotifywait -m -e modify ./Vagrantfile | 
   while read path _ file; do 
       echo "$path$file modified"
       vagrant validate
   done 