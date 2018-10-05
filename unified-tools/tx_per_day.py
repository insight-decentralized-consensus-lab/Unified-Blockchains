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
    start = data['time'].values[0]
    end = data['time'].values[-1]
    step = 3600*24
    df1 = data[["time","ntx"]]
    # print(df1)
    df2 = df1.groupby(pd.cut(data["time"], np.arange(start-1,end+1,step))).sum()
    print(df2)
    # with pd.option_context('display.max_rows', None):
        # print(pd.cut(data["time"], np.arange(1538213319,1538521008,30768.7)))
    # print(data)
    # df.groupby(pd.cut(df["B"], np.arange(0, 1.0+0.155, 0.155))).sum()



































    
    # data["datetime"] = pd.to_datetime(data["time"], unit='s')
    # data["ntx"] = data.groupby("datetime")["tx"].transform("count")
    # 
    # newdata = data.groupby('datetime')["ntx"].sum()
    # print(newdata)
    # grouped = df.groupby('Year')
    # print grouped['Points'].agg(np.mean)
    # print(data["ntx"])
    # print(data["datetime"].Date.value_counts())
    # print(data.groupby(data.datetime.dt.day))
    # data.set_index("datetime").groupby(data["datetime"].dt.date).mean()
    # print(data)
    # print(type(pd.to_datetime(data["time"], unit='s')))
    # print(type(data))
    # print(data["tx"].str.len())
