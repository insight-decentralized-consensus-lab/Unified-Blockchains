default=$HOME/ethereum-json
echo "Set ethereum-json dir, default: [$default]"
read -p '' ethereumjson
ethereumjson=${ethereumjson:-$default}

default=$HOME/unified-ethereum-json
echo "Set unified-ethereum-json dir, default: [$default]"
read -p '' unifiedjson
unifiedjson=${unifiedjson:-$default}

default="10.0.0.12"
echo "Set unified server ip, default: [$default]"
read -p '' unifiedhost
unifiedhost=${unifiedhost:-$default}

default="/home/ubuntu/unified-json/ethereum/"
echo "Set path on unified, default: [$default]"
read -p '' unifiedpath
unifiedpath=${unifiedpath:-$default}


echo ethereumjson: $ethereumjson > ethereum.config
echo unifiedjson: $unifiedjson >> ethereum.config
echo unifiedhost: $unifiedhost >> ethereum.config
echo unifiedpath: $unifiedpath >> ethereum.config

echo "Done. Settings saved in ethereum.config"
