#!/bin/bash
# share.sh
# compresses chosen folder, uploads to server, and returns a publicly sharable link
# % 
# % created by Srinivas Gorur-Shandilya at 10:20 , 09 April 2014. Contact me at http://srinivas.gs/contact/
# % 
# % This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
# % To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.

# make a random string
index=0
str=""
for i in {a..z}; do arr[index]=$i; index=`expr ${index} + 1`; done
for i in {A..Z}; do arr[index]=$i; index=`expr ${index} + 1`; done
for i in {0..9}; do arr[index]=$i; index=`expr ${index} + 1`; done
for i in {1..6}; do str="$str${arr[$RANDOM%$index]}"; done

# compress chosen folder
folder_name=$1
zip_name=$str".zip"
echo "Compressing into" $zip_name
zip -r -X -q $zip_name $1 # -X flag removes junk that Mac OS X adds

# get the login name from some file (assumes you have public-key SSH set up)
login_id=$(<~/.server_id)

# copy to server
scp $zip_name $login_id:/Library/WebServer/Documents/

# copy public link to clipboard 
echo $login_id/$zip_name | pbcopy
echo "Link copied to clipboard"


