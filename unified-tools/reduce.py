import pandas as pd
from os import listdir
import matplotlib.pyplot as plt

# with open("1.csv") as f:
    # data = pd.read_json(f)

df_list = []
for infile in listdir("output/"):
    with open("output/"+str(infile)) as f:
        df_list.append(pd.read_csv(f))
        

df_sum = sum(df_list)/10000
# print(df_sum)
ax = df_sum.plot(title="Ethereum transactions per week since Aug 2015")
ax.set_xlabel("Weeks since genesis")
ax.set_ylabel("Transactions per week (x10000)")
# plt.figure()
# plt.show()
plt.savefig("eth.png")
