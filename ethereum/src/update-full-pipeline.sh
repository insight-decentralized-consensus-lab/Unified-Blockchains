echo "Get current block..."
current_block=$(($(geth attach --exec 'eth.blockNumber')-1))
twentyk_blocks_back=$(($current_block-40000))

for i in `seq $twentyk_blocks_back $current_block`
do
    if [ ! -f /home/ubuntu/mod-unified-ethereum-json/$i.json ]
    then
	hex=$( printf "%X" $i )
	outfile=$( printf "/home/ubuntu/ethereum-json/%07d.json \n" $i )
	curl -s --data '{"method":"eth_getBlockByNumber","params":["0x'${hex}'",true],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545 -o $outfile
	lastfile=$( printf "/home/ubuntu/ethereum-json/%07d.json \n" $(($i-1)) )
	unified=$( printf "/home/ubuntu/mod-unified-ethereum-json/%07d.json \n" $(($i-1)) )
	python3 single-block-to-unified-mod.py $lastfile $unified
	scp $unified 10.0.0.12:/home/ubuntu/unified-json/mod-ethereum/
    fi
done
echo "Updated to: $current_block"
