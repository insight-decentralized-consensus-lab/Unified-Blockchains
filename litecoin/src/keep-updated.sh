#!/usr/bin/env bash
if [ -z $1 ]
then
    echo "Error: need to input the latest block the pipeline has already processed"
    echo "usage: ./keep-updated.sh 545054"
    exit 1
else
    last_block=$1
fi
if [ ! $(grep "success: True" ../setup.config | awk '{print $2}') ]
then
    echo "Error: pipeline needs to be setup first. Run ./initial-config.sh followed by ./initial-setup.sh from litecoin directory"
    exit 1
fi

while true
do
    sleep 10
    current_block=$(litecoin-cli getblockchaininfo | grep blocks | sed 's@  "blocks": @@g; s@,@@g')
    if [ $(($current_block - $last_block)) -gt 1 ]
    then
	./update-full-pipeline.sh $last_block
	last_block=$(($current_block-1))
    fi
done
