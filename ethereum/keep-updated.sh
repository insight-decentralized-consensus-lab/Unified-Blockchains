last_block=6396847

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
