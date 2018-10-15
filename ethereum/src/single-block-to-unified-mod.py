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
    tx = {}
    tx["hash"] = "null"
    tx["from"] = "miner"
    tx["to"] = data["result"]["miner"]
    if(unifiedblock["num"]<4370000):
        tx["value"] = 5
    else:
        tx["value"] = 3
    tx_list.append(copy.deepcopy(tx))

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
# with open("seth.txt") as f:
    # line = f.readline()
    # count = 0
    # while(line):
        # unify("/home/ubuntu/ethereum-json/"+line[:-1],"/home/ubuntu/mod-unified-ethereum-json/"+line[:-1])
        # line = f.readline()
        # count+=1
        # if(count%1000==0):
            # print(count)
