aws s3 cp ~/bitcoin-json/$1 s3://bitcoin-json-raw/
scp ~/unified-bitcoin-json/$1 10.0.0.12:/home/ubuntu/unified-json/bitcoin/$1
rm ~/bitcoin-json/$1
