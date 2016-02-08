#!/bin/bash
#
# script name : 
#   delugeup.bash
#
# takes as arguments:
#       - $1 : Amazon EC2 Instance URL
#
#

# check for expected arguments. exit if parameters are missing.
EXPECTED_ARGS="1"
E_BADARGS="76"
E_SUCCESS="0"
if [ $# -ne $EXPECTED_ARGS ]
then
  echo -e "\n"
  echo -e "Usage:"
  echo -e "\t $0 instance"
  echo -e "Where:"
  echo -e "\t instance: Amazon EC2 Instance URL (i.e. 'ec2-52-79-44-199.ap-northeast-2.compute.amazonaws.com')"
  echo -e "\n"
  exit $E_BADARGS
fi

# determine which SSH key to use from pem files found in the user directory
source selectfilelisting.bash ~ pem 2>/dev/null

# set variables
echo "setting variables... "
instance="$1" && echo "$0 set instance=$instance"
key="$LISTING" && echo "$0 set key=$key"

ssh -i $key ubuntu@$1 "sudo adduser --disabled-password --system --home /var/lib/deluge --gecos delugeserver --group deluge"
ssh -i $key ubuntu@$1 "sudo touch /var/log/deluged.log"
ssh -i $key ubuntu@$1 "sudo touch /var/log/deluge-web.log"
ssh -i $key ubuntu@$1 "sudo chown -R deluge:deluge /var/log/deluge*"
ssh -i $key ubuntu@$1 "sudo apt-get update"
ssh -i $key ubuntu@$1 "sudo apt-get install -y deluged"
ssh -i $key ubuntu@$1 "sudo apt-get install -y deluge-webui"
ssh -i $key ubuntu@$1 "sudo curl -o /etc/default/deluge-daemon  https://s3-ap-northeast-1.amazonaws.com/scriptious/etc_default_deluge-daemon"
ssh -i $key ubuntu@$1 "sudo curl -o /etc/init.d/deluge-daemon  https://s3-ap-northeast-1.amazonaws.com/scriptious/etc_init.d_deluge-daemon"
ssh -i $key ubuntu@$1 "sudo chmod a+x /etc/init.d/deluge-daemon"
ssh -i $key ubuntu@$1 "sudo /etc/init.d/deluge-daemon start"

echo " "
echo " "
echo "$0 : to log in to $instance please use the following command: ssh -i ~/Downloads/tokyomobile.pem ubuntu@$1 -L:8112:127.0.0.1:8112"
echo "$0 : to change file ownership in the download directory please use the following command: ssh -i $key ubuntu@$1 sudo chown -R ubuntu:ubuntu /var/lib/deluge/*"
echo "$0 : to copy files please use the following command: scp -i $key ubuntu@$1:/var/lib/deluge/*/* ."
exit $E_SUCCESS
