#!bin/bash
# basic startup script
set -e -x
if [ $(wget -q -O - http://169.254.169.254/latest/meta-data/public-keys/) == "0=mystagingkey" ]; then
	export STAGING=true
else
	export STAGING=false
fi
export LOG_SETUP=/var/log/server-setup.log
export INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
export MACHINE_NAME=cool-server.butolabs.tv

### Your build items to go here
#eg yum update -y
