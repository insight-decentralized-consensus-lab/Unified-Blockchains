
block_range() {
    for i in `seq $1 $2`
    do
	echo $i `bitcoin-cli getblockhash $i`
    done
}

for i in `seq 0 15`
do
    start=$(($i * 33850))
    end=$(($i * 33850 + 33850))
    block_range $start $end &
    # sleep 1
done
# block_range 0 10000
# block_range 1000 2000 &
# block_range 0 1000 &
# block_range 0 1000 &
# block_range 0 1000 &
# block_range 0 1000 &

wait
