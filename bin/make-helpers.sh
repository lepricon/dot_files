#!/bin/bash

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
    make -f Makefile "$@" 2>&1 | tee $BUILD_LOG_FILE
}

function mu()
{
    TARGET=$1
    shift
    mgmake SECONDARY=1 ${TARGET} "$@" 2>&1 | tee $BUILD_LOG_FILE
}

function mur()
{
    mgmake SECONDARY=1 ut-run"$@"
}

function me()
{
    TARGET_NAME=`get_exe_target_name $1`
    shift
    mgmake ${TARGET_NAME} "$@" 2>&1 | tee $BUILD_LOG_FILE
}

function msc()
{
    TARGET_SHORT=$1
    shift
    mgmake sct-clean-logs sct-coal SC=${TARGET_SHORT} "$@"
}

function msr()
{
    TARGET_SHORT=$1
    shift
    mgmake SC=${TARGET_SHORT^^} sct-clean-logs sct-run "$@"
}

function med()
{
    me $1 && msc "$@"
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

function run_silent_and_log()
{
    LOG=$1
    shift
    CMD_WITH_ARGS=$@
    eval "time $CMD_WITH_ARGS 2>&1 </dev/null >/dev/null"
    echo "$LOG"
}

function freshen-project()
{
    if [ $# -ne 2 ]; then
        echo "Usage: $0 <component name> <ut target>"
    else
        echo "Starting 'me $1', 'mu $2', 'mt && vim' simultaneously..."
        ( run_silent_and_log "me done" me $1 ) &
        ( run_silent_and_log "mu done" mu $2 ) &
        ( run_silent_and_log "mt done" mt  &&
            run_silent_and_log "vim done" nohup vim +UpdateTypesFileOnly +q ) &
        wait
        echo "All jobs are done."
    fi
}

function mgcc9()
{
    $@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\"
}

func_run=`basename $0`

eval $func_run $@

