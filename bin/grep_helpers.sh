#!/bin/bash

if [ $# -lt 2 ]; then
    echo "USAGE: $0 <pattern> <path> <grep-args>"
    exit 1
fi

PATH_TO_SEARCH=$1
PATTERN=`echo $2 | sed -e 's/ /\\\\ /g'`
shift 2
EXTRA_GREP_ARGS=$@

function g()
{
    find ${PATH_TO_SEARCH} -type f | grep -v "\.svn" | xargs -I@ grep --binary-files=without-match --color -Hn "${PATTERN}" @ ${EXTRA_GREP_ARGS}
}

function gcpp()
{
    find_srcs ${PATH_TO_SEARCH} | xargs -I filename grep --color -Hn "${PATTERN}" filename ${EXTRA_GREP_ARGS}
}

function gcppc()
{
    find_srcs ${PATH_TO_SEARCH} | xargs -I filename grep --color -Hn "[^I~]${PATTERN}[>(]" filename ${EXTRA_GREP_ARGS}
}

function gcppt()
{
    find_srcs ${PATH_TO_SEARCH} | grep -v Test_modules | xargs -I filename grep --color -Hn "${PATTERN}" filename ${EXTRA_GREP_ARGS}
}

function gcpptu()
{
    find_srcs ${PATH_TO_SEARCH} | grep -v Test_modules | grep -iv "${PATTERN}" | xargs -I filename grep --color -Hn "${PATTERN}" filename ${EXTRA_GREP_ARGS}
}

FUNC_REQUESTED=`basename $0`

eval $FUNC_REQUESTED

