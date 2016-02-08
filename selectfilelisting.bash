#!/bin/bash 
#
# name : 
#	selectfilelisting.bash
#
# author:
#	Munair
#
# purpose:
#	Find and list the files of a certain extension. Prompt the user to select one and return that specific listing.
#
# takes as arguments:
#       - $1 : search directory for find utility
#	- $2 : file extension of the files to be listed
#

# check for expected arguments. exit if parameters are missing.
EXPECTED_ARGS="2"
E_BADARGS="76"
if [ $# -ne $EXPECTED_ARGS ]
then
  echo -e "\n"
  echo -e "Usage:"
  echo -e "\t $0 directory extension"
  echo -e "Where:"
  echo -e "\t directory: search directory (i.e. '~')"
  echo -e "\t extension: file extension (i.e. 'pem')"
  echo -e "\n"
  exit $E_BADARGS
fi

# define variables
directory="$1" && echo "$0 set directory=$directory"
extension="$2" && echo "$0 set extension=$extension"
declare -i counter=0 && echo "$0 set counter=$counter"
declare -f lsext && echo "set lsext=$lsext"

# create a function to display progress while another command is in process
echo "$0 ceating a function to display progress while another command is in process... "
function progress () {
  echo -n "$0 in progress. please wait..."
  while true
  do
    echo -n "."
    sleep 3
  done
} && echo "$0 created the function."

# create a find function that will run like a regular unix command
# note - functions are executed in the current shell context without creating any new process to interpret them
echo "$0 creating a find function that will run like a regular unix command... "
function lsext () {
  find $directory -type f -iname '*.'$extension'' 2>/dev/null | xargs echo | sed -e "s/^/(/" | sed -e "s/$/)/" ;
} && echo "$0 created the function."

# start the progress function and 
# use the eval built-in command to capture standard out values in the present running shell
progress &
pid=$!
eval "$( (lsext) > >(echo list=$(cat)))" 
kill $pid >&2 2>/dev/null
echo "$0 done."
echo "$0 discovered the following the $extension files in the $directory directory... "

for listing in ${list[@]}
do
  echo -e "$counter:\t\t $listing"
  options[$counter]=$counter
  counter=$counter+1
done

echo -ne "please enter selection:\t\t"
read response
while [[ $response != ${options[${response}]} ]]
do
  echo "$0 received a response that was not valid. please try again... "
  read response
done 
echo "$0 exporting ${list[$response]} to LISTING"
export LISTING="${list[$response]}"
