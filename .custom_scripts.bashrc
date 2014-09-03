# LTE project specific scripts

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"

function get_exe_target_name()
{
    TARGET_SHORT=$1
    case ${TARGET_SHORT} in
        rrom )
            echo ptRROMexe ;;
        enbc )
            echo ptENBC ;;
        tupc )
            echo ptTUPCexe ;;
        cellc )
            echo ptCELLC ;;
        uec )
            echo ptUECexe ;;
    esac
}

function mgmake()
{
    make -f Makefile $@ 2>&1 | tee $BUILD_LOG_FILE
}

function mu()
{
    TARGET=$1
    shift
    mgmake SECONDARY=1 ${TARGET} 2>&1 | tee $BUILD_LOG_FILE
}

function mur()
{
    mgmake SECONDARY=1 ut-run$@
}

function me()
{
    TARGET_NAME=`get_exe_target_name $1`
    shift
    mgmake ${TARGET_NAME} 2>&1 | tee $BUILD_LOG_FILE
}

function msc()
{
    TARGET_SHORT=$1
    shift
    mgmake sct-clean-logs sct-coal SC=${TARGET_SHORT} $@
}

function msr()
{
    TARGET_SHORT=$1
    shift
    mgmake SC=${TARGET_SHORT^^} sct-clean-logs sct-run $@
}

function med()
{
    me $1 && msc $@
}

function mud()
{
    mu $1 && mur
}

function mt()
{
    mgmake ctags
}

function gitup-externals()
{
    git svn rebase && mgmake externals
}

function freshen-project()
{
    if [ $# -ne 2 ]; then
        echo "Usage: $0 <component name> <ut target>"
    else
        echo "Starting 'me $1', 'mu $2', 'mt && vim' simultaneously..."
        ( me $1 < /dev/null 2 &> 1 > /dev/null ) &
        ( mu $2 < /dev/null 2 &> 1 > /dev/null ) &
        ( mt < /dev/null 2 &> 1 > /dev/null && nohup vim +UpdateTypesFileOnly +q < /dev/null 2 &> 1 > /dev/null ) &
        wait
        echo "All jobs are done."
    fi
}

function git_branch_name () { git br | grep "*" | cut -d" " -f2; }
function svndiff () { svn diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl; }
function svndiffless () { svn diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl | less -R; }
function svndiffvim () { svn diff --diff-cmd=$HOME/bin/svndiffvimdiff.sh $@; }
function svndiffvimhelper () { svn diff --diff-cmd=$HOME/bin/svndiff_vim_helper $@; }
function colordiff () { diff $@ | $HOME/ide/colordiff-1.0.10/colordiff.pl; }

function xte()
{
    xterm -into $( cat ~/.tabbed.xid ) &
}

function v()
{
    FILE_NAME=`echo "$1" | cut -d":" -f1`
    LINE_NUMBER=`echo "$1" | cut -d":" -f2`
    echo "$1" | grep ":" > /dev/null
    if [ $? -eq 0 ]; then
        PARAMS="$FILE_NAME +$LINE_NUMBER"
    else
        PARAMS="$FILE_NAME"
    fi
    vim $PARAMS
}

function vv()
{
    LOG_FILE_PATH=$1
    vim -c "/Final Verdict:" `find $LOG_FILE_PATH -name *.k3.txt`
}

function ve()
{
    vim -c \"Cscope e $1\"
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

