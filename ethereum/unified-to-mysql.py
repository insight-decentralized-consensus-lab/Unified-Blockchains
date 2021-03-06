import mysql.connector
import os
import json
from os import listdir
from os.path import isfile, join

USER = os.environ["MYSQL_USER"]
PASS = os.environ["MYSQL_PASS"]

mydb = mysql.connector.connect(
      host="localhost",
      user=USER,
      passwd=PASS,
      database="ethereum"
)

mycursor = mydb.cursor()
print("Open file list...")
with open("mod.txt") as f:
    filelist = f.read().splitlines()
print("Sort file list...")
slist = sorted(filelist)
sql = "INSERT INTO blocks (number , hash, parenthash, childhash, numtx, timestamp, coin, miner, reward) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
val = []
# insert into table
count = 0
print("Start inserting...")
for onefile in slist:
    with open(onefile) as f:
        data = json.load(f)
        # block = (data["num"], data["hash"], data["parent"], data["child"], len(data["tx"]), data["time"], data["coin"], "null", 0)
        block = (data["num"], data["hash"], data["parent"], data["child"], len(data["tx"]), data["time"], data["coin"], data["tx"][0]["to"], data["tx"][0]["value"])
        val.append(block)
        # print(block)
        # print(data["tx"])
    # print(onefile)
    count += 1
    if(count % 1000 == 0):
        print(str(count)+"/"+str(len(slist)))
        mycursor.executemany(sql, val)
        mydb.commit()
        print(mycursor.rowcount, "was inserted.")
        val.clear()
        # break
# print(val)
# exit(1)
# val = [
    # (1, "hash1","hash0","hash2",2,456,"btc","addr",50),
    # (2, "hash2","hash1","hash3",2,456,"btc","addr",50)
# ]


# mycursor.executemany(sql, val)
# mydb.commit()



# mycursor.execute("SELECT * FROM blocks")

# myresult = mycursor.fetchall()

# for x in myresult:
      # print(x)
      
