if [ ! -f litecoin.config ]
then
    echo "No litecoin.config file found, run initial-config.sh first"
    exit 1
fi
litecoinjson=$(grep litecoinjson: litecoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: litecoin.config | awk '{print $2}')
unifiedhost=$(grep unifiedhost: litecoin.config | awk '{print $2}')
unifiedpath=$(grep unifiedpath: litecoin.config | awk '{print $2}')

if [ -z $litecoinjson ]
then
    echo "Error: litecoin.config exists but litecoinjson missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedjson ]
then
    echo "Error: litecoin.config exists but unifiedjson missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedhost ]
then
    echo "Error: litecoin.config exists but unifiedhost missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedpath ]
then
    echo "Error: litecoin.config exists but unifiedpath missing, run initial-config.sh again"
    exit 1
fi
mkdir -p $litecoinjson
mkdir -p $unifiedjson
echo "Attempting to connect to unified host, 5 second timeout"
ssh -o ConnectTimeout=5 $unifiedhost "echo Unified host connection successful."
if [ ! $? -eq 0 ]
then
    echo "Error connecting to unified host, check config and ~/.ssh/config"
    echo 'Should be able to "ssh' "$unifiedhost" '"'
    echo "success: False" > setup.config
    exit 1
fi

ssh $unifiedhost "mkdir -p $unifiedpath"

# s3bucket=$(grep s3bucket: litecoin.config | awk '{print $2}')
# if [ -z $s3bucket ]
# then
    # echo "Note: s3 not set up, s3 archiving will be turned off. Make sure you have enough free space (more than 1TB is required)"
    # echo "s3status: OFF" > setup.config
# else
    # s3status=$(aws s3 ls s3:// | grep $s3bucket | awk '{print $3}')
    # if [ -z $s3status ] 
    # then
	# echo "Error: s3 is set up but misconfigured, double check bucket configuration"
	# exit 1
    # else
	# echo "s3status: ON" > setup.config
    # fi
# fi

if [ -z $(which litecoin-cli) ]
then
    echo "Error: The litecoin daemon is not installed."
    echo "install litecoin core daemon and run via litecoind -daemon then try again"
    echo "success: False" > setup.config
    exit 1
fi

echo "Checking litecoin-cli connection"
if [ ! "$(litecoin-cli getblockhash 0)" = "12a765e31ffd4059bada1e25190f6e98c99d9714d334efa41a195a7e7e04bfe2" ]
then
    echo "Error connecting to litecoin daemon, is it running? run litecoind -deamon and try again."
    echo "success: False" > setup.config
    exit 1
fi


echo "success: True" >> setup.config
echo "Setup successful."

