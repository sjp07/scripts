#!/bin/bash
#-------------------------------------------------------------------------------
# checkStacks.sh   spaul  Version 1.0 1/28/2014
# 
# Runs from the management server in QA ENV.
# Display package builds and version on MGMT,Login,Admin,Controller,DB servers
#-------------------------------------------------------------------------------
# Set colors for text diplay output
#-------------------------------------------------------------------------------
REVERSE=$(tput setaf 7) 
NORMAL=$(tput sgr0) 
REVERSE=$(tput smso)
# Mgmt
#-------------------------------------------------------------------------------
 showpackages > cs.tmp
 grep management cs.tmp  > cs2.tmp
 grep maven cs.tmp > cs3.tmp
#-------------------------------------------------------------------------------
#  Format output 
#-------------------------------------------------------------------------------
# Add Environment to output for /ect/motd  #message of the day file on mgmtserver
#
printf "_____________________________________________________________\n"
grep ENV /etc/motd  
#-------------------------------------------------------------------------------
# Mgmt Server
#-------------------------------------------------------------------------------
printf "Package              \t\tBuild Date       Time\n"
printf "_____________________________________________________________\n"
printf "\n%s \n" "${REVERSE}Mgmt Server${NORMAL}"
awk -F- '{printf "%s-%s-%s\t%s %s/%s/%s %s\n",$1,$2,$3,$4,\
substr($5,1,4),substr($5,5,2),substr($5,7,2),substr($5,9,6)}' <cs2.tmp
awk -F- '{printf "%s-%s\t\t%s %s/%s/%s %s\n", $1,$2,$3,\
substr($4,1,4),substr($4,5,2),substr($4,7,2),substr($4,9,6)}' <cs3.tmp
#-------------------------------------------------------------------------------
# Login Server
#-------------------------------------------------------------------------------
printf "\n%s \n" "${REVERSE}Login Server${NORMAL}"
ssh root@192.168.11.13 'rpm -q singlepoint-studio-login-server' |\
 awk -F- '{printf "%s-%s-%s-%s\t%s %s/%s/%s %s\n", $1,$2,$3,$4,$5,\
substr($6,1,4),substr($6,5,2),substr($6,7,2),substr($6,9,6)}'
printf "\n_____________________________________________________________\n"
#-------------------------------------------------------------------------------
# STACK 1
#-------------------------------------------------------------------------------
# Admin Server 
#-------------------------------------------------------------------------------
printf "%s \n" "Stack1"
printf "%s \n" "${REVERSE}Admin Server${NORMAL}"
ssh root@192.168.11.10 'rpm -q singlepoint-admin-server' |\
awk -F- '{printf "%s-%s-%s\t%s %s/%s/%s %s\n",$1,$2,$3,$4,\
substr($5,1,4),substr($5,5,2),substr($5,7,2),substr($5,9,6)}' 
#-------------------------------------------------------------------------------
# Controller1 Server
#-------------------------------------------------------------------------------
printf "%s \n" "${REVERSE}Controller1 Server${NORMAL}"
ssh root@192.168.11.11 'rpm -q singlepoint-controller-server' |\
awk -F- '{printf "%s-%s-%s\t%s %s/%s/%s %s\n",$1,$2,$3,$4,\
substr($5,1,4),substr($5,5,2),substr($5,7,2),substr($5,9,6)}' 
#-------------------------------------------------------------------------------
# Database1 Server
#-------------------------------------------------------------------------------
printf "%s \n" "${REVERSE}Database Server${NORMAL}"
ssh 192.168.11.12 'mysql --database="singlepoint"  -e "select * from database_version;"' |\
awk '{OFS=":"; FS="\n"} {printf "%s \t\t ", $1 }'
printf "\n_____________________________________________________________\n\n"
#-------------------------------------------------------------------------------
# STACK 2
#-------------------------------------------------------------------------------
# Admin2 Server 
#-------------------------------------------------------------------------------
printf "%s \n" "Stack2"
printf "%s \n" "${REVERSE}Admin2 Server${NORMAL}"
ssh root@192.168.11.20 'rpm -q singlepoint-admin-server' |\
awk -F- '{printf "%s-%s-%s\t%s %s/%s/%s %s\n",$1,$2,$3,$4,\
substr($5,1,4),substr($5,5,2),substr($5,7,2),substr($5,9,6)}' 
#-------------------------------------------------------------------------------
# Controller2 Server
#-------------------------------------------------------------------------------
printf "%s \n" "${REVERSE}Controller2 Server${NORMAL}"
ssh root@192.168.11.21 'rpm -q singlepoint-controller-server' |\
awk -F- '{printf "%s-%s-%s\t%s %s/%s/%s %s\n",$1,$2,$3,$4,\
substr($5,1,4),substr($5,5,2),substr($5,7,2),substr($5,9,6)}' 
#-------------------------------------------------------------------------------
# Database2 Server
#-------------------------------------------------------------------------------
printf "%s \n" "${REVERSE}Database2 Server${NORMAL}"
ssh 192.168.11.22 'mysql --database="singlepoint"  -e "select * from database_version;"' |\
awk '{OFS=":"; FS="\n"} {printf "%s \t\t", $1 }'
printf "\n_____________________________________________________________\n\n"
