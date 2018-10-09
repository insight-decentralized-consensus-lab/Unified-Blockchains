for i in `find /home/ubuntu/bitcoin-json/ -name "*.json" | sort`
do
    outfile=`echo $i | sed 's@bitcoin-json@unified-bitcoin-json@g'`
    python3 block-json-to-unified.py $i $outfile
done
