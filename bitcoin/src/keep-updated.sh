#!/usr/bin/env bash
if [ -z $1 ]
then
    echo "Error: need to input the latest block the pipeline has already processed"
    echo "usage: ./keep-updated.sh 545054"
    exit 1
else
    last_block=$1
fi

while true
do
    sleep 10
    current_block=$(bitcoin-cli getblockchaininfo | grep blocks | sed 's@  "blocks": @@g; s@,@@g')
    if [ $(($current_block - $last_block)) -gt 1 ]
    then
	./update-full-pipeline.sh
	last_block=$(($current_block-1))
    fi
done

    

