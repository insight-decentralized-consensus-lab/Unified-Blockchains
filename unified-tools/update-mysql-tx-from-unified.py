import json
import sys
from unified_utils import *

supported_coins = ["bitcoin","ethereum","litecoin"]

if(len(sys.argv)<2 or sys.argv[1] not in supported_coins ):
    print("run via:")
    print("python3 "+sys.argv[0]+" <coin>")
    sys.exit(1)
else:
    coin = sys.argv[1] 

mydb     = get_db(coin)
config   = get_config(coin)    # looks for coinname.json
filelist = get_filelist(config)  # specified in config
mycursor = mydb.cursor()

sql = "INSERT INTO transactions (tx_id, _to, _from, block, block_hash, timestamp, amount, coin) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
val = []
count = 0

### Get the end of the blockchain in the database and append new blocks
print("Get last block that was previously inserted...")
mycursor.execute("SELECT MAX(block) FROM transactions")
myresult = mycursor.fetchall()
for x in myresult:
    blocks_inserted = x[0]
if(blocks_inserted):
    list_to_process = filelist[(blocks_inserted+1):]
else:
    list_to_process = filelist

### Insert new data into MySQL 1000 rows at a time for performance
print("Insert new data...")
for onefile in list_to_process:
    with open(onefile) as f:
        data = json.load(f)
        for tx in data["tx"]:
            # (tx_id, _to, _from, block, block_hash, timestamp, amount, coin)
            transaction = (tx["hash"],tx["to"],tx["from"],data["num"],data["hash"],data["time"],tx["value"],data["coin"] )
            val.append(transaction)
            count += 1
            if(count % 1000 == 0):
                print(str(count)+"/"+str(len(list_to_process))+" | block: "+str(data["num"]))
                mycursor.executemany(sql, val)
                mydb.commit()
                print(mycursor.rowcount, "was inserted.")
                val.clear()

### Write the final bit of data that didn't make it into the last 1000 rows
if(val):
    mycursor.executemany(sql, val)
    mydb.commit()
    print(mycursor.rowcount, "was inserted.")
    
