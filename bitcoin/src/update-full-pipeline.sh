echo "Get current block..."
current_block=$(($(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')-1))
echo "Update all..."
bitcoinjson=$(grep bitcoinjson: ../bitcoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ../bitcoin.config | awk '{print $2}')

for i in `seq $1 $current_block`
do
    if [ ! -f $unifiedjson/$i.json ]
    then
	bitcoin-cli getblockhash $i | xargs -I % bitcoin-cli getblock % 2 > $bitcoinjson/$i.json
	python3 single-raw-to-unified.py /home/ubuntu/bitcoin-json/$i.json $unifiedjson/$i.json
	./archive-single.sh $i.json &
    fi
done
