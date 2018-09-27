import mysql.connector
import json
from os import listdir
from os.path import isfile, join
import sys, os

supported_coins = ["bitcoin","ethereum","litecoin"]

if(len(sys.argv)<2 or sys.argv[1] not in supported_coins ):
    print("run via:")
    print("python3 "+sys.argv[0]+" <coin>")
    sys.exit(1)
else:
    coin = sys.argv[1] 

USER = os.environ["MYSQL_USER"]
PASS = os.environ["MYSQL_PASS"]

mydb = mysql.connector.connect(
      host="localhost",
      user=USER,
      passwd=PASS,
      database=coin
)

### Get coin specific information from config file
print("Reading config file...")
try:
    with open(coin+".json") as config_file:
        config = json.load(config_file)
except Exception as e:
    if isinstance(e,FileNotFoundError):
        print("Missing config file: "+coin+".json , check docs for help.")
    elif isinstance(e,TypeError):
        print("config file: "+coin+".json is not formatted properly.")
    else:
        print(e)
    sys.exit(1)

### Read input filelist specified in config file
print("Reading input filelist...")
mycursor = mydb.cursor()
print("Open file list...")
try:
    with open(config["filelist"]) as f:
        filelist = f.read().splitlines()
except Exception as e:
    if isinstance(e,FileNotFoundError):
        print("Inpurt filelist specified in "+coin+".json not found.")
    else:
        print(e)
    sys.exit(1)

sql = "INSERT INTO blocks (number , hash, parenthash, childhash, numtx, timestamp, coin, miner, reward) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
val = []
count = 0

### Get the end of the blockchain in the database and append new blocks
print("Get last block that was previously inserted...")
mycursor.execute("SELECT MAX(number) FROM blocks")
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
        block = (data["num"], data["hash"], data["parent"], data["child"], len(data["tx"]), data["time"], data["coin"], data["tx"][0]["to"], data["tx"][0]["value"])
        val.append(block)
        count += 1
        if(count % 1000 == 0):
            print(str(count)+"/"+str(len(list_to_process)))
            mycursor.executemany(sql, val)
            mydb.commit()
            print(mycursor.rowcount, "was inserted.")
            val.clear()

### Write the final bit of data that didn't make it into the last 1000 rows
if(val):
    mycursor.executemany(sql, val)
    mydb.commit()
    print(mycursor.rowcount, "was inserted.")
    
