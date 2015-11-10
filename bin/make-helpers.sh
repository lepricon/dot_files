#!/bin/bash

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"
EXE_REMOTE_HOST=wrling144.emea.nsn-net.net
UT_REMOTE_HOST=wrlcplane11.emea.nsn-net.net
CLANG_REMOTE_HOST=wrlcplane12.emea.nsn-net.net

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

function mgmake()
{
    make -f Makefile "$@" 2>&1 | tee ${BUILD_LOG_FILE}
}

function mu()
{
    UT_TARGET=$1
    shift
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ${UT_TARGET} "$@" 2>&1 | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "Build" ${UT_TARGET} "$@"
}

function mur()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ut-run"$@"
    notifyBuildFinished "UT run" "$@"
}

function mvur()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ut-valgrind-run"$@"
    notifyBuildFinished "UT run" "$@"
}

function me()
{
    EXE_TARGET=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} ${EXE_TARGET} "$@" 2>&1 | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "Build" ${EXE_TARGET} "$@"
}

function msc()
{
    COMPONENT_NAME=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} sct-clean-logs sct-coal SC=${COMPONENT_NAME} "$@"
    notifyBuildFinished "Coalescense run" ${TARGET_SHORT} "$@"
}

function msr()
{
    COMPONENT_NAME=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} SC=${COMPONENT_NAME^^} _sct-clean-logs-remote sct-run "$@" | tee ${BUILD_LOG_FILE}
    notifyBuildFinished "SCT run" ${TARGET_SHORT} "$@"
}

function med()
{
    EXE_TARGET=$1
    shift
    me ${EXE_TARGET} && msc "$@"
}

function mud()
{
    UT_TARGET=$1
    shift
    mu ${UT_TARGET} && mur "$@"
}

function mt()
{
    echo -ne "\nStarted"
    ( run_silent_and_log "ctags" mgmake ctags ) &
    ( run_silent_and_log "gtags" gtags -c ) &
    wait
    notifyBuildFinished "Tags generated"
}

function mtloop()
{
    COUNTER=1
    VIM_UPDATE_FREQ=5
    PAUSE_TIME=60
    while true ; do
        run_silent_and_log "ctags" make -f Makefile ctags 2>&1
        run_silent_and_log "gtags" gtags -c
        if [ $COUNTER -eq 0 ]; then
            run_silent_and_log "vim highlight" nohup vim +UpdateTypesFileOnly +q
        fi
        run_silent_and_log "pause for $PAUSE_TIME s" sleep $PAUSE_TIME
        COUNTER=$(( (COUNTER + 1) % VIM_UPDATE_FREQ ))
    done
}

function mclean_all_my_remote()
{
    mgmake remove-remote REMOTE_HOST=${EXE_REMOTE_HOST}
    mgmake remove-remote REMOTE_HOST=${UT_REMOTE_HOST}
    mgmake remove-remote REMOTE_HOST=${CLANG_REMOTE_HOST}
}

function mif()
{
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} interfaces
    freshen_project mt
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

function freshen_project()
{
    echo -ne "\nStarted"
    if [ $# -ge 1 -a "$1" != "_" ]; then
        ( run_silent_and_log "mt" mt &&
            run_silent_and_log "vim" nohup vim +UpdateTypesFileOnly +q ) &
    fi
    if [ $# -ge 2 -a "$2" != "_" ]; then
        ( run_silent_and_log "me $2" me $2 ) &
    fi
    if [ $# -ge 3 -a "$3" != "_" ]; then
        ( run_silent_and_log "mu $3" mu $3 ) &
    fi
    if [ $# -ge 4 -a "$4" != "_" ]; then
        ( run_silent_and_log "mclang mu $4" mclang mu $4 ) &
    fi
    sleep 0.1
    echo ". Waiting..."
    wait
    notifyBuildFinished "Project re-freshing" "$@"
}

function mgcc9()
{
    #$@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\"

    GCC_EXE=$(ssh $UT_REMOTE_HOST 'echo "/opt/gcc/linux64/ix86/`ls /opt/gcc/linux64/ix86/ | sort | tail -n 1`/bin/c++"')
    $@ MAKE_PARAMS=\"CXX=$GCC_EXE\"
}

function mclang()
{
    $@ REMOTE_HOST=${CLANG_REMOTE_HOST} MAKE_PARAMS=\'CLANG=\"yes_please\"\'
}

func_run=`basename $0`

eval $func_run $@

