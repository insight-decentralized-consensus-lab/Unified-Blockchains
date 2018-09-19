block_range() {
    for i in `seq $1 $2`
    do
	if [ $(( $i % 1000 )) -eq 0 ]
	then
	    echo $i
	fi
	hex=$( printf "%X" $i )
	outfile=$( printf "/home/ubuntu/ethereum-json/%07d.json \n" $i )
	curl -s --data '{"method":"eth_getBlockByNumber","params":["0x'${hex}'",true],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545 -o $outfile
    done
}

step=$((1000000 / $1))
echo $step

for i in `seq 0 $(($1-1))`
do
    start=$(($i * $step))
    end=$(($i * $step + $step))
    block_range $start $end &
done

wait
