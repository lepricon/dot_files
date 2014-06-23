#!/bin/bash

SVN_REPO_SERVER="wrling102.emea.nsn-net.net"
SVN_REPO_PATH="/var/fpwork/vvolkov/remote/svn/trunk"
SCRIPT_PATH="/home/kgrobeln/bin/taxReport"
REVISIONS=$1

function fetch_zipped_revisions()
{
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && $SCRIPT_PATH -r=${REVISIONS}''"
    scp $SVN_REPO_SERVER:$SVN_REPO_PATH/${REVISIONS}.zip .
    ssh $SVN_REPO_SERVER ''rm $SVN_REPO_PATH/${REVISIONS}.zip''
}


if [[ $# -eq 0 ]]; then
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && $SCRIPT_PATH''"
elif [[ "$1" == "up"  ]]; then
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && svn up''"
else
    fetch_zipped_revisions
fi

