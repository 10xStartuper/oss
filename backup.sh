#!/bin/bash

## author: genemator
## my blog: bsba.uz/genemator
##
## backup your app configuration
##

. log.sh

# source backup_script.sh
. backup_script.sh

EXIT_MSG="You have left from OSS Linux!"
Config_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## window
title="Backup Application Configuration"
msg="Please select the configuration you want to backup. [ESC] to exit the installer"

# get all config from backup.conf
config_list=$(grep -P "^\s*[a-zA-Z0-9-]+\s*[a-zA-Z0-9-]*" backup.conf | xargs)
count=0
for item in $config_list
do
    count=$[ $count + 1 ]
    judge=$[ $count % 2 ]

    if [ "$judge" = "0" ]
    then
        temp="$temp $item ON"
    else
        temp="$temp $item"
    fi
done
config_list=$temp

### Application Name and description
dialog --no-cancel --ok-label "Backup" --ascii-lines --title "$title" --backtitle "$HEADER" --checklist "$msg" 18 75 18 $config_list 2>tempfile

retval=$?
choice=$(cat tempfile)
echo

# ESC to exit
case $retval in 
	255) # ESC,exit
		echo 
		echo $EXIT_MSG
		exit 255
		;;
esac

### execute the configuration
for app in $choice
do
backup_$app >/dev/null 2>&1
    if [ "$?" = "0" ]
    then
        echo "Backup $app successfully!"
    else
        echo "No backup script for $app or there are some backup error,please check log file!"
    fi
done