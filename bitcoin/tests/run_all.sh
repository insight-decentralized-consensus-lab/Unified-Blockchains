#!/usr/bin/env bash
if [ ! $(grep "success: True" ../setup.config | awk '{print $2}') ]
then
    echo "Error: pipeline needs to be setup first. Run ./initial-config.sh followed by ./initial-setup.sh from bitcoin directory"
    exit 1
fi

unifiedjson=$(grep unifiedjson: ../bitcoin.config | awk '{print $2}')



### Check block hash info for early block ###
block97hash='"000000000ecab80b1bee41b0bff9514502d7d8c62bb842655da7b30008c891cc"'
hash=$(jq '.hash' $unifiedjson/000097.json)

if [[ $hash = $block97hash ]]
then
    echo -e "\e[92mPass block 97 hash test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/000097.json
    echo looking for a hash value of $block97hash
    echo found $hash
fi


### Check transaction info for early block ###
block97miner='"1Bq1TLyuvZLvu73eueduUMhBL2QfYDeoNt"'
miner=$(jq '.tx[0].to' $unifiedjson/000097.json)

if [[ $miner = $block97miner ]]
then
    echo -e "\e[92mPass block 97 miner test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/000097.json
    echo looking for a hash value of $block97miner
    echo found $miner
fi


### Check block hash info for late block ###
block597hash='"0000000000000000003795502b86d6dfd015b9fe8fa68e9374ce71c683b63f22"'
hash=$(jq '.hash' $unifiedjson/500097.json)

if [[ $hash = $block597hash ]]
then
    echo -e "\e[92mPass block 500097 hash test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/500097.json
    echo looking for a hash value of $block597hash
    echo found $hash
fi


### Check transaction info for late block ###
block597miner='"1CK6KHY6MHgYvmRQ4PAafKYDrg1ejbH1cE"'
miner=$(jq '.tx[0].to' $unifiedjson/500097.json)

if [[ $miner = $block597miner ]]
then
    echo -e "\e[92mPass block 500097 miner test.\e[0m"
else
    echo -e "\e[31mFail block hash test.\e[0m"
    echo $unifiedjson/500097.json
    echo looking for a hash value of $block597miner
    echo found $miner
fi


