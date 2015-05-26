#!/bin/bash

LOG_PATH_RELATIVE=$( echo $1 | sed 's|k3.txt|log|' )
SCT_RUN_PATH=${PWD}

pushd ~/workspace/sctflow_pkg
./run.sh ${SCT_RUN_PATH}/${LOG_PATH_RELATIVE} && firefox _out/index.html 2>&1 > /dev/null
popd
