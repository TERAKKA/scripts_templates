#!/bin/bash

DIR="/home/user/directory/"	#path to dir
TYPE="*.type"	#type file
#TYPE1="*.type"
#TYPE2="*.type"
#TYPE3="*.type"
TIME="N-minute"	#for n+1 minute, exam: 30 = 31+ min old files

if [ `find $DIR -name $TYPE -mmin +$TIME -maxdepth 1 -type f -exec echo {} \;|wc -l` -gt 0 ] #del -type f for check catalogs
#if [ `find $DIR -name $TYPE -o -name $TYPE1 -o -name $TYPE2 -o -name $TYPE3 -mmin +$TIME -type f -exec echo {} \;|wc -l` -gt 0 ]
then
   echo "1"
#else
#   echo "0"
fi
exit 0