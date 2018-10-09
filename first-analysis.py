import pandas as pd
import glob

filenames = glob.glob("/home/ubuntu/unified-bitcoin-json/00000*.json")

list_of_dfs = [pd.read_json(filename) for filename in filenames]

print(list_of_dfs)
# pd.read_json("/home/ubuntu/unified-bitcoin-json/*.json")
# data = pd.read_json("/home/ubuntu/unified-bitcoin-json/00000*.json")
# print(data["hash"])
