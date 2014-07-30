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

ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "sudo apt-get install -y git-core"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "git clone https://github.com/munair/setup.git"
ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1 "bash -x setup/nodeup.bash $2"

echo " "
echo " "
echo "to log in to $2 please use the following command:"
echo "ssh -i ~/Downloads/tokyoyawd.pem ubuntu@$1"
