start="["
end="]"
num=0
progress=0
last=$(tail -n1 uej.list)
last=${last%".json"}
filename=$(printf "cluster.%04d.json" $num)
echo $start > /home/ubuntu/unified-ethereum-cluster/$filename
for i in `seq 0 $last`
do
    if [ $(($progress % 1000)) -eq 0 ]
    then
	echo $progress/$last
    fi
    input=$(printf "%07d.json" $i)
    cat /home/ubuntu/mod-unified-ethereum-json/$input >> /home/ubuntu/unified-ethereum-cluster/$filename
    size=$(ls -s /home/ubuntu/unified-ethereum-cluster/$filename | awk '{print $1}')
    if [ $size -gt 578992 ]
    then
	echo $end >> /home/ubuntu/unified-ethereum-cluster/$filename
	num=$(($num+1))
	filename=$(printf "cluster.%04d.json" $num)
	echo $start > /home/ubuntu/unified-ethereum-cluster/$filename
    else
	echo , >> /home/ubuntu/unified-ethereum-cluster/$filename
    fi
    progress=$(($progress+1))
done
echo $end >> /home/ubuntu/unified-ethereum-cluster/$filename
