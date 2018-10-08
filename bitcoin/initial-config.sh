default=$HOME/bitcoin-json
echo "Set bitcoin-json dir, default: [$default]"
read -p '' bitcoinjson
bitcoinjson=${name:-$default}

default=$HOME/unified-bitcoin-json
echo "Set unified-bitcoin-json dir, default: [$default]"
read -p '' unifiedbitcoinjson
unifiedbitcoinjson=${name:-$default}


# mkdir 
# mkdir $HOME/unified-bitcoin-json


