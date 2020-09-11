#!/bin/bash

if [ "$(whoami)" = "root" ]
then
    echo
    echo
    echo "---------------------------------OSS Linux-------------------------------"
    echo "you should not run this script as root"
    echo
    echo
    exit 0;
fi
