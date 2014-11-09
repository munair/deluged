#!/bin/bash
#
# script name : 
#   nodeup.bash
#
# takes as arguments:
#       - $1 : Amazon EC2 Instance URL
#       - $2 : Repository on GitHub [Uses Munair"s Account]
#
#

ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo adduser --disabled-password --system --home /var/lib/deluge --gecos delugeserver --group deluge"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo touch /var/log/deluged.log"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo touch /var/log/deluge-web.log"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo chown deluge:deluge /var/log/deluge*"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo apt-get update"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo apt-get install -y deluged"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo apt-get install -y deluge-webui"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo curl -o /etc/default/deluge-daemon  https://s3-ap-northeast-1.amazonaws.com/scriptious/etc_default_deluge-daemon"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo curl -o /etc/init.d/deluge-daemon  https://s3-ap-northeast-1.amazonaws.com/scriptious/etc_init.d_deluge-daemon"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo chmod a+x /etc/init.d/deluge-daemon"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo /etc/init.d/deluge-daemon start"

echo " "
echo " "
echo "to log in to $2 please use the following command:"
echo "ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1"
