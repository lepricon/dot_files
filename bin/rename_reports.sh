#!/bin/bash

for OLD_NAME in $@; do
    RISK_TYPE=`cat $OLD_NAME | grep "PropertyType>.*</PropertyType" | sed 's|.*PropertyType>\(.*\)</PropertyType.*|\1|g'`
    CALC_METHOD=`cat $OLD_NAME | grep "Calculation method=.*${RISK_TYPE}" | sed 's|.*\"\(.*\)\" dis.*|\1|g'`
    echo "$OLD_NAME -> ${RISK_TYPE}-${CALC_METHOD}.xml"
    mv $OLD_NAME "${RISK_TYPE}-${CALC_METHOD}.xml"
done
