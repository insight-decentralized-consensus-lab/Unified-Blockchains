bitcoinjson=$(grep bitcoinjson: ../bitcoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ../bitcoin.config | awk '{print $2}')
unifiedhost=$(grep unifiedhost: ../bitcoin.config | awk '{print $2}')
unifiedpath=$(grep unifiedpath: ../bitcoin.config | awk '{print $2}')

if [ ! -z $(grep "s3status: ON" ../setup.config | awk '{print $2}') ]
then
    s3bucket=$(grep s3bucket: ../bitcoin.config | awk '{print $2}')
    aws s3 cp $bitcoinjson/$1 s3://$s3bucket/
fi


scp $unifiedjson/$1 $unifiedhost:$unifiedpath/$1
rm $bitcoinjson/$1
