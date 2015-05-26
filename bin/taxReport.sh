#!/bin/bash

SCRIPT="/home/vvolkov/workspace/taxReport/TaxReport_v2.rb"
REVISIONS=$@
BACKUP_DIR="/home/vvolkov/Dropbox/Docs/TaxBreak/tax-report"

$SCRIPT --mail-from=volodymyr.volkov@nsn.com --mail-to=volodymyr.volkov@nsn.com --wrling=wrling46.emea.nsn-net.net ${REVISIONS}
mv tax-report/* $BACKUP_DIR
rm -rf tax-report

