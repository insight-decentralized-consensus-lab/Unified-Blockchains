start="["
end="]"
num=0
progress=0
last=$(tail -n1 ulj.list)
last=${last%".json"}
filename=$(printf "cluster.%04d.json" $num)
echo $start > /home/ubuntu/unified-litecoin-cluster/$filename
for i in `cat ulj.list`
do
    if [ $(($progress % 1000)) -eq 0 ]
    then
	echo $progress/$last
    fi
    cat /home/ubuntu/unified-litecoin-json/$i >> /home/ubuntu/unified-litecoin-cluster/$filename
    size=$(ls -s /home/ubuntu/unified-litecoin-cluster/$filename | awk '{print $1}')
    if [ $size -gt 578992 ]
    then
	echo $end >> /home/ubuntu/unified-litecoin-cluster/$filename
	num=$(($num+1))
	filename=$(printf "cluster.%04d.json" $num)
	echo $start > /home/ubuntu/unified-litecoin-cluster/$filename
    else
	echo , >> /home/ubuntu/unified-litecoin-cluster/$filename
    fi
    progress=$(($progress+1))
done
echo $end >> /home/ubuntu/unified-litecoin-cluster/$filename
