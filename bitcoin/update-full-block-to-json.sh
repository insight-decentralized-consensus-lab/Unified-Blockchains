# cat ~/sort-hash.txt | awk '{printf("bitcoin-cli getblock %s 2 > bitcoin-json/%06d.json \n", $2,$1)}' | bash

cat ~/sort-num-hash.txt | while read line
do
    data=($line)
    if [ ! -f ~/unified-bitcoin-json/${data[0]}.json ]
    then
	bitcoin-cli getblock ${data[1]} > ~/bitcoin-json/${data[0]}.json 2
    fi
done
