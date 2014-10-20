#!/bin/bash

function v()
{
    FILE_NAME=`echo "$1" | cut -d":" -f1`
    LINE_NUMBER=`echo "$1" | cut -d":" -f2`
    echo "$1" | grep ":" > /dev/null
    if [ $? -eq 0 ]; then
        PARAMS="$FILE_NAME +$LINE_NUMBER"
    else
        PARAMS="$FILE_NAME"
    fi
    vim $PARAMS
}

function vv()
{
    LOG_FILE_PATH=$1
    vim -c "/Final Verdict:" `find $LOG_FILE_PATH -name *.k3.txt`
}

FUNC_REQUESTED=`basename $0`

eval $FUNC_REQUESTED $@

