#!/usr/bin/env bash

# substitutes <sed-pattern> in all files <file1>..<fileN>

if (( $# == 0 )); then
    echo "Usage:"
    echo "$0 <sed-pattern> <file1> .... <fileN>"
    exit 1
fi

SED_PATTERN=$1
shift
FILES=$@

TEMP_FILE=`mktemp`

for file in $FILES; do
    cat $file | sed "$SED_PATTERN" > $TEMP_FILE
    if (( $? != 0 )); then
        exit 1
    fi
    mv $TEMP_FILE $file
done
