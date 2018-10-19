echo "Get current block..."
current_block=$(litecoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')
last_processed=$(find /home/ubuntu/litecoin-json/ -name "*.json" | sort | tail -n1 | sed 's@/home/ubuntu/litecoin-json/@@g' | sed 's@.json@@g')
echo "Processing..."
echo "for i in $last_processed $current_block"
# for i in `seq $last_processed $(($last_processed+10))`
for i in `seq $last_processed $current_block`
do
    filename=$(printf "%07d.json" $i)
    litecoin-cli getblockhash $i | xargs -I % litecoin-cli getblock % 2 > /home/ubuntu/litecoin-json/$filename
    python3 single-raw-to-unified.py /home/ubuntu/litecoin-json/$filename /home/ubuntu/unified-litecoin-json/$filename
    # scp -i $KEY_FILE /home/ubuntu/unified-litecoin-json/$filename 10.0.0.12:/home/ubuntu/unified-json/litecoin/
done
