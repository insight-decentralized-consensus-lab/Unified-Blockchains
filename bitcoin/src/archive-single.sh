if [ ! -z $(grep "s3status: ON" ../setup.config | awk '{print $2}') ]
then
    aws s3 cp ~/bitcoin-json/$1 s3://bitcoin-json-raw/
fi
bitcoinjson=$(grep bitcoinjson: ../bitcoin.config | awk '{print $2}')
unifiedjson=$(grep unifiedjson: ../bitcoin.config | awk '{print $2}')
unifiedhost=$(grep unifiedhost: ../bitcoin.config | awk '{print $2}')
unifiedpath=$(grep unifiedpath: ../bitcoin.config | awk '{print $2}')

scp $unifiedjson/$1 $unifiedhost:$unifiedpath/$1
rm $bitcoinjson/$1
