#!/bin/bash 

#Usage generateUsers.sh <number_of_desired_users>

echo "Generating ${1} users for your enjoyment!"

echo "Username,Application Name,CredentialName1,CredentialValue1,CredentialName2,CredentialValue2" > ${1}users.csv

for ((count=1; count<=${1}; count++))
 do
	echo user$count,Concur,userid,user$count,password,testing$count >> ${1}users.csv
 done
 
 echo "The file ${1}users.csv has been generated for import into your IDR."
 
