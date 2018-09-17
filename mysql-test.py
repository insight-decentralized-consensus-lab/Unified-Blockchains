import mysql.connector
import os

USER = os.environ["MYSQL_USER"]
PASS = os.environ["MYSQL_PASS"]

mydb = mysql.connector.connect(
      host="localhost",
      user=USER,
      passwd=PASS,
      database="bitcoin"
)

# print(mydb)

mycursor = mydb.cursor()

# create DB
# mycursor.execute("CREATE DATABASE blockchains")

# drop Table
# mycursor.execute("DROP TABLE blocks")
# mycursor.execute("DROP TABLE transactions")
# mycursor.execute("DROP TABLE addresses")

# create Table
# mycursor.execute("CREATE TABLE blocks (id INT AUTO_INCREMENT PRIMARY KEY, number INT, hash VARCHAR(255), parenthash VARCHAR(255), childhash VARCHAR(255), numtx INT, timestamp INT, nonce INT, coin VARCHAR(5), miner VARCHAR(255), reward DOUBLE)")

# mycursor.execute("CREATE TABLE transactions (id INT AUTO_INCREMENT PRIMARY KEY, tx_id VARCHAR(255), _to VARCHAR(255), _from VARCHAR(255), block INT, block_hash VARCHAR(255), timestamp INT, amount DOUBLE, coin VARCHAR(5))")

# mycursor.execute("CREATE TABLE addresses (id INT AUTO_INCREMENT PRIMARY KEY, ad_id VARCHAR(255), balance DOUBLE, created_blockhash VARCHAR(255), accessed_blockhash VARCHAR(255), accessed_timestamp INT, coin VARCHAR(5))")

# mycursor.execute("SHOW TABLES")

# print(type(mycursor))
# for x in mycursor:
    # print(x)

