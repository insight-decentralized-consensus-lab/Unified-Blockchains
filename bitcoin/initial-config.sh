default=$HOME/bitcoin-json
echo "Set bitcoin-json dir, default: [$default]"
read -p '' bitcoinjson
bitcoinjson=${bitcoinjson:-$default}

default=$HOME/unified-bitcoin-json
echo "Set unified-bitcoin-json dir, default: [$default]"
read -p '' unifiedjson
unifiedjson=${unifiedjson:-$default}

default="bitcoin-json-raw"
echo "Set s3 bucket, default: [$default]"
read -p '' s3bucket
s3bucket=${s3bucket:-$default}

default="10.0.0.12"
echo "Set unified server ip, default: [$default]"
read -p '' unifiedhost
unifiedhost=${unifiedhost:-$default}

default="/home/ubuntu/unified-json/bitcoin/"
echo "Set path on unified, default: [$default]"
read -p '' unifiedpath
unifiedpath=${unifiedpath:-$default}


# 10.0.0.12:/home/ubuntu/unified-json/bitcoin/$1

echo bitcoinjson: $bitcoinjson > bitcoin.config
echo unifiedjson: $unifiedjson >> bitcoin.config
echo s3bucket: $s3bucket >> bitcoin.config
echo unifiedhost: $unifiedhost >> bitcoin.config
echo unifiedpath: $unifiedpath >> bitcoin.config

echo "Done. Settings saved in bitcoin.config"
