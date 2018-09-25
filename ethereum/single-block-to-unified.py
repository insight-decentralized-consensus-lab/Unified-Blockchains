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

    path = infile[:-12]
    filenum = infile.replace(path,"").replace(".json","")
    nextfile=str(int(filenum)+1).zfill(7)+".json"
    with open(path+nextfile) as f2:
        child_data = json.load(f2)

    unifiedblock = {}

    unifiedblock["parent"] = data["result"]["parentHash"]
    unifiedblock["hash"] = data["result"]["hash"]
    unifiedblock["child"] = child_data["result"]["hash"]
    unifiedblock["num"] = int(data["result"]["number"], 0)
    tx_list = []

    for i in data["result"]["transactions"] :
        tx = {}
        tx["hash"] = i["hash"]
        tx["from"] = i["from"]
        tx["to"] = i["to"]
        tx["value"] = int(i["value"],0)/1000000000000000000
        
        tx_list.append(copy.deepcopy(tx))
        
    unifiedblock["tx"] = tx_list
    unifiedblock["time"] = int(data["result"]["timestamp"],0)
    unifiedblock["coin"] = "eth"


    with open(outfile, 'w') as outfile:
        json.dump(unifiedblock, outfile, indent=4, sort_keys=True)
        outfile.write('\n')



unify(inputfile,outputfile)
