default=$HOME/bitcoin-json
echo "Set bitcoin-json dir, default: [$default]"
read -p '' bitcoinjson
bitcoinjson=${name:-$default}

default=$HOME/unified-bitcoin-json
echo "Set unified-bitcoin-json dir, default: [$default]"
read -p '' unifiedjson
unifiedjson=${name:-$default}

default="bitcoin-json-raw"
echo "Set s3 bucket, default: [$default]"
read -p '' s3bucket
s3bucket=${name:-$default}

echo bitcoinjson: $bitcoinjson > bitcoin.config
echo unifiedjson: $unifiedjson >> bitcoin.config
echo s3bucket: $s3bucket >> bitcoin.config

echo "Done. Settings saved in bitcoin.config"
