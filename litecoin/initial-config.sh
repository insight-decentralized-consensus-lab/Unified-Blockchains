default=$HOME/litecoin-json
echo "Set litecoin-json dir, default: [$default]"
read -p '' litecoinjson
litecoinjson=${litecoinjson:-$default}

default=$HOME/unified-litecoin-json
echo "Set unified-litecoin-json dir, default: [$default]"
read -p '' unifiedjson
unifiedjson=${unifiedjson:-$default}

# default="litecoin-json-raw"
# echo "Set s3 bucket, default: [$default]"
# read -p '' s3bucket
# s3bucket=${s3bucket:-$default}

default="10.0.0.12"
echo "Set unified server ip, default: [$default]"
read -p '' unifiedhost
unifiedhost=${unifiedhost:-$default}

default="/home/ubuntu/unified-json/litecoin/"
echo "Set path on unified, default: [$default]"
read -p '' unifiedpath
unifiedpath=${unifiedpath:-$default}


# 10.0.0.12:/home/ubuntu/unified-json/litecoin/$1

echo litecoinjson: $litecoinjson > litecoin.config
echo unifiedjson: $unifiedjson >> litecoin.config
# echo s3bucket: $s3bucket >> litecoin.config
echo unifiedhost: $unifiedhost >> litecoin.config
echo unifiedpath: $unifiedpath >> litecoin.config

echo "Done. Settings saved in litecoin.config"
