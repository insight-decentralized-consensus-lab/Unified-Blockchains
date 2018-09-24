echo "Get current block..."
current_block=$(bitcoin-cli getblockchaininfo | grep "blocks" | awk '{print $2}' | sed 's@,@@g')
echo "Get what has already been processed..."
# last=$(tail -n1 total.txt)
# last=${last%".json"}
for i in `seq 0 ${current_block}` ; do printf "%06d.json\n" $i >> total.txt ; done
find /home/ubuntu/bitcoin-json/ /home/ubuntu/unified-bitcoin-json/ -name "*.json" | sed 's@/home/ubuntu/unified-bitcoin-json/@@g' | sed 's@/home/ubuntu/bitcoin-json/@@g' | sort | uniq > processed.txt
diff total.txt processed.txt | grep json | awk '{print $2}' > .raw-to-process.txt
rm processed.txt
echo "Update raw json..."
exit
# cat .raw-to-process.txt | awk '{printf("bitcoin-cli getblock %s 2 > ~/bitcoin-json/%06d.json \n", $2,$1)}' | bash
for i in `cat .raw-to-process.txt`
do
    hash=$(bitcoin-cli getblockhash ${i%".json"})
    bitcoin-cli getblock $hash 2 > /home/ubuntu/bitcoin-json/$i
done
