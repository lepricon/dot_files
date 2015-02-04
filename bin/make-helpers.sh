#!/bin/bash

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"
EXE_REMOTE_HOST=wrling108.emea.nsn-net.net
UT_REMOTE_HOST=wrlcplane22.emea.nsn-net.net
CLANG_REMOTE_HOST=wrlcplane11.emea.nsn-net.net

function notifyBuildFinished()
{
    EXIT_CODE=$?
    ACTION=$1
    shift
    if [ $EXIT_CODE -eq 0 ]; then
        RESULT="succeeded"
    else
        RESULT="failed"
    fi

    MSG_TITLE="$ACTION $RESULT"
    MSG_BODY="$@"
    notify-send --urgency=low -i "$([ $EXIT_CODE -eq 0 ] && echo terminal || echo error)" "$MSG_TITLE" "$MSG_BODY"

    return $EXIT_CODE
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
    make -f Makefile "$@" 2>&1 | tee ${BUILD_LOG_FILE}
}

function mu()
{
    TARGET=$1
    shift
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ${TARGET} "$@" 2>&1 | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "Build" ${TARGET} "$@"
}

function mur()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ut-run"$@"
}

function me()
{
    TARGET=`get_exe_target_name $1`
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} ${TARGET} "$@" 2>&1 | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "Build" ${TARGET} "$@"
}

function msc()
{
    TARGET_SHORT=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} sct-clean-logs sct-coal SC=${TARGET_SHORT} "$@"
    notifyBuildFinished "Coalescense run" ${TARGET_SHORT} "$@"
}

function msr()
{
    TARGET_SHORT=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} SC=${TARGET_SHORT^^} sct-clean-logs sct-run "$@" | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "SCT run" ${TARGET_SHORT} "$@"
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
    echo -ne "\nStarted"
    ( run_silent_and_log "ctags" mgmake ctags ) &
    ( run_silent_and_log "gtags" gtags -c ) &
    wait
    notifyBuildFinished "Tags generated"
}

function git-if()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} interfaces
    freshen-project $1 $2
}

function run_silent_and_log()
{
    LOG_PREFIX=$1
    shift
    CMD_WITH_ARGS=$@
    echo -n " '$CMD_WITH_ARGS' "
    if eval "time $CMD_WITH_ARGS </dev/null 1>/dev/null 2>/dev/null"; then
        LOG_MSG="$LOG_PREFIX done success"
    else
        LOG_MSG="$LOG_PREFIX done failure"
    fi
    echo "$LOG_MSG"
}

function freshen-project()
{
    echo -ne "\nStarted"
    if [ $# -ge 1 -a "$1" = "mt" ]; then
        ( run_silent_and_log "mt" mt &&
            run_silent_and_log "vim" nohup vim +UpdateTypesFileOnly +q ) &
    fi
    if [ $# -ge 2 ]; then
        ( run_silent_and_log "me" me $2 ) &
    fi
    if [ $# -ge 3 ]; then
        ( run_silent_and_log "mu" mu $3 ) &
    fi
    if [ $# -ge 4 ]; then
        ( run_silent_and_log "mclang mu" mclang mu $4 ) &
    fi
    sleep 0.1
    echo ". Waiting..."
    wait
    notifyBuildFinished "Project re-freshing" "$@"
}

function mgcc9()
{
    ( $@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\" )
}

function mclang()
{
    ( $@ REMOTE_HOST=${CLANG_REMOTE_HOST} MAKE_PARAMS=\'CLANG=\"yes_please\"\' )
}

func_run=`basename $0`

eval $func_run $@

