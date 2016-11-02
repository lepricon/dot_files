#!/bin/bash

set -o pipefail

BUILD_LOG_FILE="/tmp/mgmake-build-log"
BUILD_LOG_FILE_EXE="/tmp/mgmake-build-log-exe"
BUILD_LOG_FILE_UT="/tmp/mgmake-build-log-ut"
EXE_REMOTE_HOST=
UT_REMOTE_HOST=
CLANG_REMOTE_HOST=

notifyBuildFinished()
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

mgmake()
{
    make -f Makefile "$@" 2>&1 | tee >(perl -pe 's/\e\[?.*?[\@-~]//g' > ${BUILD_LOG_FILE})
}

mu()
{
    UT_TARGET=$1
    shift
    make -f Makefile REMOTE_HOST=${UT_REMOTE_HOST} ${UT_TARGET} "$@" 2>&1 | tee >(perl -pe 's/\e\[?.*?[\@-~]//g' > ${BUILD_LOG_FILE_UT})
    notifyBuildFinished "Build" ${UT_TARGET} "$@"
}

mur()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ut-run"$@"
    notifyBuildFinished "UT run" "$@"
}

mvur()
{
    mgmake REMOTE_HOST=${UT_REMOTE_HOST} ut-valgrind-run"$@"
    notifyBuildFinished "UT run" "$@"
}

me()
{
    EXE_TARGET=$1
    shift
    make -f Makefile REMOTE_HOST=${EXE_REMOTE_HOST} ${EXE_TARGET} "$@" 2>&1 | tee >(perl -pe 's/\e\[?.*?[\@-~]//g' > ${BUILD_LOG_FILE_EXE})
    notifyBuildFinished "Build" ${EXE_TARGET} "$@"
}

mep()
{
    me MAKE_PARAMS+=DISTCC=1 MAKE_PARAMS+=CBE_MEASURE_TIME= "$@"
}

mup()
{
    mu MAKE_PARAMS+=DISTCC=1 MAKE_PARAMS+=CBE_MEASURE_TIME= "$@"
}

msc()
{
    COMPONENT_NAME=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} sct-clean-logs sct-coal SC=${COMPONENT_NAME} "$@"
    notifyBuildFinished "Coalescense run" ${TARGET_SHORT} "$@"
}

msr()
{
    COMPONENT_NAME=$1
    shift
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} SC=${COMPONENT_NAME^^} _sct-clean-logs-remote sct-run "$@"
    notifyBuildFinished "SCT run" ${TARGET_SHORT} "$@"
}

med()
{
    EXE_TARGET=$1
    shift
    mep ${EXE_TARGET} && msc "$@"
}

mud()
{
    UT_TARGET=$1
    shift
    mup ${UT_TARGET} && mur "$@"
}


find_and_ctag()
{
    find . \( -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' \) > srcs.txt && \
    ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -L srcs.txt && \
    rm srcs.txt
}

mt()
{
    echo -ne "\nStarted"

    ( run_silent_and_log "ctags" find_and_ctag &&
          run_silent_and_log "vim highlighting" nohup vim +UpdateTypesFileOnly +q ) &
    ( run_silent_and_log "gtags" gtags -c ) &

    wait
    notifyBuildFinished "Tags generated"
}

mtv()
{
    mt && nohup vim +UpdateTypesFileOnly +q
}

mtloop()
{
    COUNTER=0
    VIM_UPDATE_FREQ=5
    PAUSE_TIME=60
    while true ; do
        run_silent_and_log "ctags" make -f Makefile ctags 2>&1
        run_silent_and_log "gtags" gtags
        if [ $COUNTER -eq 0 ]; then
            run_silent_and_log "vim highlighting" nohup vim +UpdateTypesFileOnly +q
        fi
        run_silent_and_log "pause for $PAUSE_TIME s" sleep $PAUSE_TIME
        COUNTER=$(( (COUNTER + 1) % VIM_UPDATE_FREQ ))
    done
}

mclean_all_my_remote()
{
    mgmake remove-remote REMOTE_HOST=${EXE_REMOTE_HOST}
    mgmake remove-remote REMOTE_HOST=${UT_REMOTE_HOST}
    mgmake remove-remote REMOTE_HOST=${CLANG_REMOTE_HOST}
}

mif()
{
    mgmake REMOTE_HOST=${EXE_REMOTE_HOST} interfaces
    freshen_project mt
}

run_silent_and_log()
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

freshen_project()
{
    echo -ne "\nStarted with $# commands "
    for param in "$@"; do
        if [ "$param" == "mt" ]; then
            ( run_silent_and_log "mt" mt &&
                run_silent_and_log "vim highlighting" nohup vim +UpdateTypesFileOnly +q ) &
        else
            ( run_silent_and_log "$param" $param ) &
        fi
        shift
    done

    sleep 0.1
    echo ". Waiting..."
    wait
    notifyBuildFinished "Project re-freshing" "$@"
}

mgcc9()
{
    #$@ MAKE_PARAMS=\"CXX=/opt/gcc/linux64/ix86/gcc_4.9.0-rhel6/bin/c++\"

    GCC_EXE=$(ssh $UT_REMOTE_HOST 'echo "/opt/gcc/linux64/ix86/`ls /opt/gcc/linux64/ix86/ | sort | tail -n 1`/bin/c++"')
    $* MAKE_PARAMS+=\"CXX=$GCC_EXE\"
}

mclang()
{
    $* REMOTE_HOST=${CLANG_REMOTE_HOST} MAKE_PARAMS+=CLANG=\"yes_please\"
}

func_run=`basename $0`

eval $func_run "$@"

