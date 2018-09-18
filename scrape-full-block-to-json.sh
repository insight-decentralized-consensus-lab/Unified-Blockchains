cat sort-hash.txt | awk '{printf("bitcoin-cli getblock %s 2 > bitcoin-json/%06d.json \n", $2,$1)}' | bash
