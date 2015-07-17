#!/bin/bash
#---------------------------------------------------------------------
# cpWebservers.sh spaul 3/4/14
#---------------------------------------------------------------------
# Used to copy webservers to the crwall
# requires ssh proxy 
# copies studio's data.cvs output to crwall
# location of file   ~Downloads/data.csv copy to crwall /tmp
# use addWebservers.sh on crwall to reformat and append to /etc/hosts
#---------------------------------------------------------------------
# 
#  Usage check

if [ $# -lt 1 ]; then
    echo 
    echo "Usage: $0 <QAENV> ex: $0 4"
    echo 
   exit 1
fi
#---------------------------------------------------------------------
# crwall is set up in .ssh/config file 
#
echo
echo -----------------------------------------------------------------
echo
cat ~/Downloads/data.csv
scp ~/Downloads/data.csv crwall$1:/tmp/
echo
echo -----------------------------------------------------------------
echo "copy of ~/Downloads/data.csv to crwall ENV$1 complete"
echo -----------------------------------------------------------------
echo
#---------------------------------------------------------------------
