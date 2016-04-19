#!/bin/bash

ICA_NAME=launch.ica

cp ~/workspace/ica-client/${ICA_NAME} ~/Downloads/
/opt/Citrix/ICAClient/wfica.sh ~/Downloads/${ICA_NAME} 2> /dev/null
