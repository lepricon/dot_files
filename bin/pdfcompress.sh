#!/bin/bash
INPUT="$1"

if [ $# -lt 2 ]; then
    OUTPUT=$INPUT
else
    OUTPUT="$2"
fi
TEMP=`mktemp`

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$TEMP" "$INPUT"
mv $TEMP $OUTPUT
