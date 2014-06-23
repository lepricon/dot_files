#!/bin/sh

CMD=vimdiff

BASE=$1
THEIRS=$2
MINE=$3
MERGED=$4
WCPATH=$5

#$CMD $MINE $THEIRS
$CMD $MINE $BASE $THEIRS

if [ $? -eq 0 ]; then
    cp $MINE $MERGED
fi
