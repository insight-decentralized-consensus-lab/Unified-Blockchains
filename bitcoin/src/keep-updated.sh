last_block=542999

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

    

