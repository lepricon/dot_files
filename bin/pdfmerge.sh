#!/bin/bash
OUTPUT="$1"
shift

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="$OUTPUT" "$@"

