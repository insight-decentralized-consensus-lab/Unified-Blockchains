import json
import sys, os
import copy

if(len(sys.argv)>2):
    inputfile = sys.argv[1]
    outputfile = sys.argv[2]
else:
    print("run via:")
    print("python3 "+sys.argv[0]+" <input-file> <output-file>")
    sys.exit(1)

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
    
        for j in i["vout"]:
            tx["value"] = j["value"]
            try:
                tx["to"] = j["scriptPubKey"]["addresses"][0]
            except:
                tx["to"] = ""
            tx_list.append(copy.deepcopy(tx))

    unifiedblock["tx"] = tx_list
    unifiedblock["time"] = data["time"]
    unifiedblock["coin"] = "ltc"

    with open(outfile, 'w') as outfile:
        json.dump(unifiedblock, outfile, indent=4, sort_keys=True)
        outfile.write('\n')




unify(inputfile,outputfile)
