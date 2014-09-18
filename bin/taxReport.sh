#!/bin/bash

SVN_REPO_SERVER="wrlcplane20.emea.nsn-net.net"
SVN_REPO_PATH="/var/fpwork/vvolkov/trunk"
SCRIPT_PATH="/home/vvolkov/tools/taxReport/TaxReport_v2.rb"
REVISION=$1

function fetch_zipped_revisions()
{
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && $SCRIPT_PATH -r=${REVISION}''"
    scp -r $SVN_REPO_SERVER:$SVN_REPO_PATH/tax-report .
    ssh $SVN_REPO_SERVER ''rm -rf $SVN_REPO_PATH/tax-report''
}


if [[ $# -eq 0 ]]; then
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && $SCRIPT_PATH''"
elif [[ "$1" == "up"  ]]; then
    ssh $SVN_REPO_SERVER "''cd $SVN_REPO_PATH && svn up''"
else
    fetch_zipped_revisions
fi

