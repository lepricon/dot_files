#!/usr/bin/env bash
TEMP=`mktemp`
find_srcs $@ | xargs -I@ cat @ > $TEMP 2>/dev/null

ALL=`cat $TEMP | wc -l`
DOXY=`cat $TEMP | /home/vvolkov2/bin/doxygen_comments_count.py`

echo $DOXY $ALL
echo "scale=5; $DOXY / $ALL" | bc

rm $TEMP
