#!/bin/bash

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"
EXE_REMOTE_HOST=wrling108.emea.nsn-net.net
UT_REMOTE_HOST=wrling121.emea.nsn-net.net
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
    make -f Makefile "$@" 2>&1 | tee $BUILD_LOG_FILE
}

function mu()
{
    TARGET=$1
    shift
    mgmake REMOTE_HOST=$UT_REMOTE_HOST ${TARGET} "$@" 2>&1 | tee $BUILD_LOG_FILE
    notifyBuildFinished "Build" ${TARGET} "$@"
}

function mur()
{
    mgmake REMOTE_HOST=$UT_REMOTE_HOST  ut-run"$@"
}

function me()
{
    TARGET=`get_exe_target_name $1`
    shift
    mgmake REMOTE_HOST=$EXE_REMOTE_HOST ${TARGET} "$@" 2>&1 | tee $BUILD_LOG_FILE
    notifyBuildFinished "Build" ${TARGET} "$@"
}

function msc()
{
    TARGET_SHORT=$1
    shift
    mgmake REMOTE_HOST=$EXE_REMOTE_HOST sct-clean-logs sct-coal SC=${TARGET_SHORT} "$@"
    notifyBuildFinished "Coalescense run" ${TARGET_SHORT} "$@"
}

function msr()
{
    TARGET_SHORT=$1
    shift
    mgmake REMOTE_HOST=$EXE_REMOTE_HOST SC=${TARGET_SHORT^^} sct-clean-logs sct-run "$@" | tee $BUILD_LOG_FILE
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
    mgmake ctags
}

function git-if()
{
    mgmake REMOTE_HOST=$UT_REMOTE_HOST interfaces
    freshen-project $1 $2
}

function run_silent_and_log()
{
    LOG_PREFIX=$1
    shift
    CMD_WITH_ARGS=$@
    if eval "time $CMD_WITH_ARGS 2>&1 </dev/null >/dev/null"; then
        LOG_MSG="$LOG_PREFIX success"
    else
        LOG_MSG="$LOG_PREFIX failure"
    fi
    echo "$LOG_MSG"
}

function freshen-project()
{
    echo -n "Started 'mt && vim'"
    ( run_silent_and_log "mt done" mt &&
        run_silent_and_log "vim done" nohup vim +UpdateTypesFileOnly +q ) &
    if [ $# -ge 1 ]; then
        echo -n " + 'me $1'"
        ( run_silent_and_log "me done" me $1 ) &
    fi
    if [ $# -ge 2 ]; then
        echo -n " + 'mu $2'"
        ( run_silent_and_log "mu done" mu $2 ) &
    fi
    if [ $# -ge 3 ]; then
        echo -n " + 'mclang mu $3'"
        ( run_silent_and_log "mclang mu done" mclang mu $3 ) &
    fi
    echo ". Waiting..."
    wait
    echo "All jobs are done."
    notifyBuildFinished "Project re-freshing" "$@"
}

function mgcc9()
{
    ( $@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\" )
    notifyBuildFinished Build mgcc9 "$@"
}

function mclang()
{
    ( $@ REMOTE_HOST=$CLANG_REMOTE_HOST MAKE_PARAMS=\"CLANG=\"yes_please\"\" )
    notifyBuildFinished Build clang "$@"
}

func_run=`basename $0`

eval $func_run $@

