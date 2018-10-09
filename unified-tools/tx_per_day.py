import pandas as pd
import numpy as np
import sys,os

if(len(sys.argv)>1):
    inputfile = sys.argv[1]
else:
    print("run via:")
    print("python3 "+sys.argv[0]+" <input-file>")
    sys.exit(1)

with open(inputfile) as f:
    data = pd.read_json(f)
    print(data.columns.values)
    data["ntx"] = data["tx"].str.len()
    start = 1438269957
    end = start + (3600*24*365)
    step = 3600*24*7
    df1 = data[["time","ntx"]]
    df2 = df1.groupby(pd.cut(data["time"], np.arange(start-1,end+1,step))).sum()
    header = ["ntx"]
    df2.to_csv("name.csv",columns=header, index=False)
