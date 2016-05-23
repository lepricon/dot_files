#!/bin/bash

SCRIPT="/home/vvolkov/workspace/taxReport/TaxReport_v2.rb"
REVISIONS=$@
BACKUP_DIR="/home/vvolkov/Dropbox/Docs/TaxBreak/tax-report"

$SCRIPT --export-dir=${BACKUP_DIR} ${REVISIONS}

