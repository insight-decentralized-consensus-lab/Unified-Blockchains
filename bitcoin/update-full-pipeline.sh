echo "Get current block..."
current_block=$(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')
last_processed=$(find /home/ubuntu/bitcoin-json/ -name "*.json" | sort | tail -n1 | sed 's@/home/ubuntu/bitcoin-json/@@g' | sed 's@.json@@g')
echo "Processing..."
for i in `seq $last_processed $current_block`
do
    bitcoin-cli getblockhash $i | xargs -I % bitcoin-cli getblock % 2 > /home/ubuntu/bitcoin-json/$i.json
    python3 single-raw-to-unified.py /home/ubuntu/bitcoin-json/$i.json /home/ubuntu/unified-bitcoin-json/$i.json
    ./archive-single.sh $i.json &
done

