git_branch_name()
{
    LINE=$( git br 2>/dev/null | grep '*' | cut -d' ' -f2 )$(svn info 2>/dev/null | grep '^URL:' | sed 's|.*/\([^/]\+\)|\1|')
    if [ -n "$LINE" ]; then
        echo "$LINE "
    fi
}

svndiff () { svn diff $@ | colordiff; }
svndiffless () { svn diff $@ | colordiff | less -R; }
svndiffvim () { svn diff --diff-cmd=$HOME/bin/svndiffvimdiff.sh $@; }
svndiffvimhelper () { svn diff --diff-cmd=$HOME/bin/svndiff_vim_helper $@; }

xte()
{
    xterm -into $( cat ~/.tabbed.xid ) &
}

settitle()
{
    if [ $# -lt 1 ]; then
        PROMPT_COMMAND='\
            echo -ne "\033]0;`basename "$PWD"`@`hostname`\007";\
            echo -ne "\033]1;`basename "$PWD"`@`hostname`\007"'
    else
        PROMPT_COMMAND="$1"
    fi
}

todayistartedat()
{
    grep -E "$(echo $(LC_ALL=en_US.UTF-8 date +"%b %d") | sed -E 's/0([1-9])/ \1/g')" /var/log/syslog* | sed -E "s/([^:]*):(.*)`hostname`(.*)/\2/g" | sort | head -n 1
}

