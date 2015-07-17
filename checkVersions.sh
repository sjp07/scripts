#!/bin/bash
#-------------------------------------------------------------------------------
# checkversion.sh   Dlumpkin/Spaul  Version 1.0 1/28/2014
# 
# Runs from the management server in QA ENV.
# Reads and parses openvpn-status.log for all ip address of IDRs
# Connects to each IDR and querys version of singlepoint-appliance installed
#-------------------------------------------------------------------------------
# create list of IDR ips and save in ipList
#-------------------------------------------------------------------------------
  ipList=$(awk -F , '{print $1}' /etc/openvpn/openvpn-status.log | grep ^[1-9])
#-------------------------------------------------------------------------------
# Get version of singlepoint-appliance by connect to each IDR in the ipList
# and save output to cv.tmp
#-------------------------------------------------------------------------------
  for i in $ipList; do echo -en "$i,"; ssh ssouser@$i 'rpm -q singlepoint-appliance'; done | sort -t, -k2 | egrep --color '[0-9]\.[0-9]\.[0-9]-.*' > cv.tmp
#-------------------------------------------------------------------------------
#  Format output 
#-------------------------------------------------------------------------------
# Add Environment to output for /ect/motd  #message of the day file on mgmtserver
# 
  tail -3 /etc/motd
#-------------------------------------------------------------------------------
printf "IDR\t\tPackage               Build Date       Time\n"
printf "_____________________________________________________________\n"
awk -F, '{printf "%s\t%s\n",$1,$2}' <cv.tmp>cv2.tmp   # even out columns using tabs
#-------------------------------------------------------------------------------
# Add spaces to text to make colums more readable
# 
awk -F- '{printf "%s-%s %s %s/%s/%s %s\n", $1,$2,$3,substr($4,1,4),substr($4,5,2),substr($4,7,2),substr($4,9,6)}' <cv2.tmp
printf "_____________________________________________________________\n\n"
#
#-------------------------------------------------------------------------------
# clean up temp files
rm cv.tmp cv2.tmp
