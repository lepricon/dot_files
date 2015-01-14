#!/bin/bash

function run_vim_reading_log()
{
    PROGRAM_TO_RUN=$2
    FILE_NAME=`echo "$1" | cut -d":" -f1`
    LINE_NUMBER=`echo "$1" | cut -d":" -f2`
    echo "$1" | grep ":" > /dev/null
    if [ $? -eq 0 ]; then
        PARAMS="$FILE_NAME +$LINE_NUMBER"
    else
        PARAMS="$FILE_NAME"
    fi
    $PROGRAM_TO_RUN $PARAMS
}

function v()
{
    run_vim_reading_log $1 vim
}

function gv()
{
    run_vim_reading_log $1 gvim
}

function vv()
{
    LOG_FILE_PATH=$1
    vim +/"Final Verdict:" `find $LOG_FILE_PATH -name *.k3.txt`
}

FUNC_REQUESTED=`basename $0`

eval $FUNC_REQUESTED $@

