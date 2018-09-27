if [ $# -ne 3 ]
then
    echo "Usage: $0 <start> <events-to-process> <n-parallel>"
    exit 1
    fi

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

step=$(($2 / $3))
echo $step

for i in `seq 0 $(($3-1))`
do
    start=$(($i * $step + $1))
    end=$(($i * $step + $step + $1))
    block_range $start $end &
done

wait
