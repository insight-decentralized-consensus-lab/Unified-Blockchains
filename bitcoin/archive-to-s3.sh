for i in `comm -12 <(cd ~/bitcoin-json; find . -name "*.json" | sort) <(cd ~/unified-bitcoin-json; find . -name "*.json" | sort)`
do
    aws s3 cp ~/bitcoin-json/$i s3://bitcoin-json-raw/
    rm ~/bitcoin-json/$i
done

