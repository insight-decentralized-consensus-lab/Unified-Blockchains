echo "Get current block..."
current_block=$(($(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')-1))
echo "Update all..."
bitcoinjson=$(grep bitcoinjson: ../bitcoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ../bitcoin.config | awk '{print $2}')

for i in `seq $1 $current_block`
do
    filename=$(printf "%06d.json" i)
    if [ ! -f $unifiedjson/$i.json ]
    then
	bitcoin-cli getblockhash $i | xargs -I % bitcoin-cli getblock % 2 > $bitcoinjson/$filename
	python3 single-raw-to-unified.py /home/ubuntu/bitcoin-json/$filename $unifiedjson/$filename
	./archive-single.sh $filename &
    fi
done
