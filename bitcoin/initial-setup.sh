if [ ! -f bitcoin.config ]
then
    echo "No bitcoin.config file found, run initial-config.sh first"
    exit 1
fi
bitcoinjson=$(grep bitcoinjson: bitcoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: bitcoin.config | awk '{print $2}')

if [ -z $bitcoinjson ]
then
    echo "Error: bitcoin.config exists but bitcoinjson missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedjson ]
then
    echo "Error: bitcoin.config exists but unifiedjson missing, run initial-config.sh again"
    exit 1
fi
mkdir -p $bitcoinjson
mkdir -p $unifiedjson

s3bucket=$(grep s3bucket: bitcoin.config | awk '{print $2}')
if [ -z $s3bucket ]
then
    echo "Note: s3 not set up, s3 archiving will be turned off. Make sure you have enough free space (more than 1TB is required)"
    echo "s3status: OFF" > setup.config
else
    s3status=$(aws s3 ls s3:// | grep $s3bucket | awk '{print $3}')
    if [ -z $s3status ] 
    then
	echo "Error: s3 is set up but misconfigured, double check bucket configuration"
	exit 1
    else
	echo "s3status: ON" > setup.config
    fi
fi

echo "success: True" >> setup.config
echo "Setup successful."

