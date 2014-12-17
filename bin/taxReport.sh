#!/bin/bash

SVN_REPO_PATH="/home/vvolkov/cplane/code/svn"
SVN_BRANCH_NAME="FB1407"
SCRIPT="/home/vvolkov/workspace/taxReport/TaxReport_v2.rb"
REVISIONS=$@
BACKUP_DIR="/home/vvolkov/Dropbox/Docs/TaxBreak/tax-report"

cd $SVN_REPO_PATH/$SVN_BRANCH_NAME
$SCRIPT --mail-from=volodymyr.volkov@nsn.com --mail-to=volodymyr.volkov@nsn.com --wrling=wrling46.emea.nsn-net.net ${REVISIONS}
mv $SVN_REPO_PATH/$SVN_BRANCH_NAME/tax-report/* $BACKUP_DIR
rm -rf $SVN_REPO_PATH/$SVN_BRANCH_NAME/tax-report

