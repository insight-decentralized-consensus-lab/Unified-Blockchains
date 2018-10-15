if [ ! -f ethereum.config ]
then
    echo "No ethereum.config file found, run initial-config.sh first"
    exit 1
fi
ethereumjson=$(grep ethereumjson: ethereum.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ethereum.config | awk '{print $2}')
unifiedhost=$(grep unifiedhost: ethereum.config | awk '{print $2}')
unifiedpath=$(grep unifiedpath: ethereum.config | awk '{print $2}')

if [ -z $ethereumjson ]
then
    echo "Error: ethereum.config exists but ethereumjson missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedjson ]
then
    echo "Error: ethereum.config exists but unifiedjson missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedhost ]
then
    echo "Error: ethereum.config exists but unifiedhost missing, run initial-config.sh again"
    exit 1
fi
if [ -z $unifiedpath ]
then
    echo "Error: ethereum.config exists but unifiedpath missing, run initial-config.sh again"
    exit 1
fi
mkdir -p $ethereumjson
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


if [ -z $(which geth) ]
then
    echo "Error: The ethereum daemon is not installed."
    echo "install geth and run via geth --rpc in a screen session, then try again"
    echo "success: False" > setup.config
    exit 1
fi

echo "Checking geth connection"
test=$(curl -s --data '{"method":"eth_getBlockByNumber","params":["0x'$( printf "%X" 0 )'",true],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545 | grep 0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3)
if [ -z $test ]
then
    echo "Error connecting to geth, is it running? run geth --rpc and try again."
    echo "success: False" > setup.config
    exit 1
fi


echo "success: True" >> setup.config
echo "Setup successful."

