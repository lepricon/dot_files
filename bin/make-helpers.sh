#!/bin/bash

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"

function notifyBuildFinished()
{
    if [ $? -eq 0 ]; then
        RESULT="succeeded"
    else
        RESULT="failed"
    fi
    notify.py "Build $RESULT" "$@"
}

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
    notifyBuildFinished ${TARGET} $@
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
    notifyBuildFinished ${TARGET_NAME} $@
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
    notify.py "Tags generated" " "
}

function git-if()
{
    mgmake interfaces
    freshen-project $1 $2
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
    echo -n "Started 'mt && vim'"
    ( run_silent_and_log "mt done" mt  &&
        run_silent_and_log "vim done" nohup vim +UpdateTypesFileOnly +q ) &
    if [ $# -ge 1 ]; then
        echo -n " + 'me $1'"
        ( run_silent_and_log "me done" me $1 ) &
    fi
    if [ $# -ge 2 ]; then
        echo -n " + 'mu $2'"
        ( run_silent_and_log "mu done" mu $2 ) &
    fi
    echo ". Waiting..."
    wait
    echo "All jobs are done."
    notify.py "Project re-freshed" "$@ "
}

function mgcc9()
{
    $@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\"
    notifyBuildFinished "mgcc9 $@"
}

func_run=`basename $0`

eval $func_run $@

