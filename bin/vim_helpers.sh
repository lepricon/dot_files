#!/bin/bash

function run_vim_with_line_column()
{
    PROGRAM_TO_RUN=$2
    FILE_NAME=`echo "$1" | cut -s -d":" -f1`
    LINE_NUMBER=`echo "$1" | cut -s -d":" -f2`
    COLUMN_NUMBER=`echo "$1" | cut -s -d":" -f3`
    if [ -n "$COLUMN_NUMBER" ]; then
        PARAMS="\"+call cursor($LINE_NUMBER, $COLUMN_NUMBER)\" $FILE_NAME"
    elif [ -n "$LINE_NUMBER" ]; then
        PARAMS="\"+call cursor($LINE_NUMBER)\" $FILE_NAME"
    else
        PARAMS="$1"
    fi
    eval $PROGRAM_TO_RUN $PARAMS
}

function v()
{
    run_vim_with_line_column $1 vim
}

function gv()
{
    run_vim_with_line_column $1 gvim
}

function vv()
{
    if [ $# -lt 1 ]; then
        LOG_FILE_PATH=`find logs/SCTs/sct_*.* -name *.k3.txt`
    else
        LOG_FILE_PATH=$1
    fi
    vim +/"inal Verdict:" `find $LOG_FILE_PATH -name *.k3.txt`
}

FUNC_REQUESTED=`basename $0`

eval $FUNC_REQUESTED "$@"

