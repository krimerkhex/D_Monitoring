#!/bin/bash

if [ $# == 1 ]
    then if [[ $1 =~ [A-Za-z] ]]
        then echo "$1"
    else
        echo "n/a"
    fi
else
echo "n/a"
fi
