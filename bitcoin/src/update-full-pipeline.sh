echo "Get current block..."
current_block=$(($(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')-1))
onek_blocks_back=$(($current_block-1000))
echo "Update all..."
for i in `seq $onek_blocks_back $current_block`
do
    if [ ! -f /home/ubuntu/unified-bitcoin-json/$i.json ]
    then
	bitcoin-cli getblockhash $i | xargs -I % bitcoin-cli getblock % 2 > /home/ubuntu/bitcoin-json/$i.json
	python3 single-raw-to-unified.py /home/ubuntu/bitcoin-json/$i.json /home/ubuntu/unified-bitcoin-json/$i.json
	./archive-single.sh $i.json &
    fi
done
