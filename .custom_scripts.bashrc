# LTE project specific scripts

function git_branch_name (){ git br 2>/dev/null | grep "*" | cut -d" " -f2; }

function svndiff () { svn diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl; }
function svndiffless () { svn diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl | less -R; }
function svndiffvim () { svn diff --diff-cmd=$HOME/bin/svndiffvimdiff.sh $@; }
function svndiffvimhelper () { svn diff --diff-cmd=$HOME/bin/svndiff_vim_helper $@; }
function colordiff () { diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl; }

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

