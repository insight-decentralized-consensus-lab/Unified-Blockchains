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
    echo "Error: pipeline needs to be setup first. Run ./initial-config.sh followed by ./initial-setup.sh from bitcoin directory"
    exit 1
fi

while true
do
      sleep 1
      current_blk=$((`geth attach --exec 'eth.blockNumber'` - 1))
      if [ $(($current_blk - $last_block)) -gt 0 ]
      then
	  ./update-full-pipeline.sh
	  last_block=$current_blk
      fi
done
