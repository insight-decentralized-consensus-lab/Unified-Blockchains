for i in `seq 0 6350455`
do
    hex=$( printf "%X" $i )
    # echo $hex
    outfile=$( printf "/home/ubuntu/ethereum-json/%06d.json \n" $i )
    curl --data '{"method":"eth_getBlockByNumber","params":["0x'${hex}'",true],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545 -o $outfile
done

