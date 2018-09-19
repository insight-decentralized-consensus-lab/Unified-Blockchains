import json
import sys, os
import copy

# read from s3
import boto3
client = boto3.client('s3')


def unify(infile, outfile):

    s3data = client.get_object(Bucket="bitcoin-json-raw", Key=infile)
    data = json.loads(s3data["Body"].read().decode("utf-8"))
    
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
    
        for j in i["vout"]:
            tx["value"] = j["value"]
            tx["to"] = j["scriptPubKey"]["addresses"][0]
            tx_list.append(copy.deepcopy(tx))

    unifiedblock["tx"] = tx_list
    unifiedblock["time"] = data["time"]
    unifiedblock["coin"] = "btc"

    with open(outfile, 'w') as outfile:
        json.dump(unifiedblock, outfile, indent=4, sort_keys=True)
        outfile.write('\n')

with open("filelist.txt") as f:
    line = f.readline()
    count = 0
    while(line):
        print(line[:-1])
        unify(line[:-1],"/home/ubuntu/"+line[:-1])
        # unify(line[:-1],"/home/ubuntu/unified-bitcoin-json/"+line[:-1])
        line = f.readline()
        count+=1
        if(count%1000==0):
            print(count)
