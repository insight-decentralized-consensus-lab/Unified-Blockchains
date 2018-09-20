import json
import sys, os
import copy

def unify(infile, outfile):

    with open(infile) as f:
        data = json.load(f)
    
    try: # needed for genesis block which has no parent
        parent = data["previousblockhash"]
    except:
        parent = 0

    unifiedblock = {}
    unifiedblock["hash"] = data["hash"]
    unifiedblock["parent"] = parent
    unifiedblock["child"] = data["nextblockhash"]
    unifiedblock["num"] = data["height"]
    tx_list = []
    for i in data["tx"] :
        tx = {}
        tx["hash"] = i["hash"]
        try:
            _from = i["vin"][0]["txid"]
        except:
            _from = "miner"
        tx["from"] = _from
        # tx["coin"] = "btc"
        # tx["blocknum"] = unifiedblock["num"]
        # tx["blockhash"] = unifiedblock["hash"]
        # tx["time"] = unifiedblock["time"]
    
        for j in i["vout"]:
            tx["value"] = j["value"]
            try:
                tx["to"] = j["scriptPubKey"]["addresses"][0]
            except:
                tx["to"] = ""
            tx_list.append(copy.deepcopy(tx))

    unifiedblock["tx"] = tx_list
    unifiedblock["time"] = data["time"]
    unifiedblock["coin"] = "btc"

    # unifiedtx = []
    # for i in data["tx"] :
    
    # unifiedaddress = []
    

    # print(unifiedblock)
    # print(unifiedtx)
    with open(outfile, 'w') as outfile:
        json.dump(unifiedblock, outfile, indent=4, sort_keys=True)
        outfile.write('\n')

with open("filelist.txt") as f:
    line = f.readline()
    count = 0
    while(line):
        print(line[:-1])
        unify("/home/ubuntu/bitcoin-json/"+line[:-1],"/home/ubuntu/unified-bitcoin-json/"+line[:-1])
        # unify(line[:-1],"/home/ubuntu/unified-bitcoin-json/"+line[:-1])
        line = f.readline()
        count+=1
        if(count%1000==0):
            print(count)
