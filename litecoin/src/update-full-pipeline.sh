litecoinjson=$(grep litecoinjson: ../litecoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ../litecoin.config | awk '{print $2}')
unifiedhost=$(grep unifiedhost: ../litecoin.config | awk '{print $2}')
unifiedpath=$(grep unifiedpath: ../litecoin.config | awk '{print $2}')

echo "Get current block..."
current_block=$(litecoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')
last_processed=$(find /home/ubuntu/litecoin-json/ -name "*.json" | sort | tail -n1 | sed 's@/home/ubuntu/litecoin-json/@@g' | sed 's@.json@@g')
echo "Processing..."
echo "for i in $last_processed $current_block"
# for i in `seq $last_processed $(($last_processed+10))`
for i in `seq $last_processed $current_block`
do
    filename=$(printf "%07d.json" $i)
    litecoin-cli getblockhash $i | xargs -I % litecoin-cli getblock % 2 > $litecoinjson/$filename
    python3 single-raw-to-unified.py $litecoinjson/$filename $unifiedjson/$filename
    scp $unifiedjson/$1 $unifiedhost:$unifiedpath/$1

done
