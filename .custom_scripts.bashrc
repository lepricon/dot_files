function git_branch_name()
{
    LINE=$( git br 2>/dev/null | grep '*' | cut -d' ' -f2 )$(svn info 2>/dev/null | grep '^URL:' | sed 's|.*/\([^/]\+\)|\1|')
    if [ -n "$LINE" ]; then
        echo "$LINE "
    fi
}

function svndiff () { svn diff $@ | colordiff; }
function svndiffless () { svn diff $@ | colordiff | less -R; }
function svndiffvim () { svn diff --diff-cmd=$HOME/bin/svndiffvimdiff.sh $@; }
function svndiffvimhelper () { svn diff --diff-cmd=$HOME/bin/svndiff_vim_helper $@; }

function xte()
{
    xterm -into $( cat ~/.tabbed.xid ) &
}

function settitle()
{
    if [ $# -lt 1 ]; then
        PROMPT_COMMAND='\
            echo -ne "\033]0;`basename "$PWD"`@`hostname`\007";\
            echo -ne "\033]1;`basename "$PWD"`@`hostname`\007"'
    else
        PROMPT_COMMAND="$1"
    fi
}

