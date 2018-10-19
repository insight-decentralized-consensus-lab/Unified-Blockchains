#!/usr/bin/env bash
if [ ! $(grep "success: True" ../setup.config | awk '{print $2}') ]
then
    echo "Error: pipeline needs to be setup first. Run ./initial-config.sh followed by ./initial-setup.sh from litecoin directory"
    exit 1
fi

unifiedjson=$(grep unifiedjson: ../litecoin.config | awk '{print $2}')



### Check block hash info for early block ###
block97hash='"524a9b19473049c8f34cba44305181f539127d1f08a965a7247a9fda9fadc0c3"'
hash=$(jq '.hash' $unifiedjson/0000097.json)

if [[ $hash = $block97hash ]]
then
    echo -e "\e[92mPass block 97 hash test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/0000097.json
    echo looking for a hash value of $block97hash
    echo found $hash
fi


### Check transaction info for early block ###
block97miner='"LdAixnCoLTwSu1GrQ3KESQerbUNLbFXp8Z"'
miner=$(jq '.tx[0].to' $unifiedjson/0000097.json)

if [[ $miner = $block97miner ]]
then
    echo -e "\e[92mPass block 97 miner test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/0000097.json
    echo looking for a hash value of $block97miner
    echo found $miner
fi


### Check block hash info for late block ###
block597hash='"66d1e05b6451296e4de7b3c8afe5c5ca655e082f328e005a50edffec72ea150a"'
hash=$(jq '.hash' $unifiedjson/1000097.json)

if [[ $hash = $block597hash ]]
then
    echo -e "\e[92mPass block 1000097 hash test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/1000097.json
    echo looking for a hash value of $block597hash
    echo found $hash
fi


### Check transaction info for late block ###
block597miner='"LSqCzf5bPfkqGf94pJcfxWx5bZMPJE5XRf"'
miner=$(jq '.tx[0].to' $unifiedjson/1000097.json)

if [[ $miner = $block597miner ]]
then
    echo -e "\e[92mPass block 1000097 miner test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/1000097.json
    echo looking for a hash value of $block597miner
    echo found $miner
fi


