# Unified-Blockchains
Data analysis toolkit for data across blockchains

## Multiple Blockchains, one data format
This repository combines data from multiple blockchains in different formats into a standard, unified format, in order to perform analyses across blockchains agnostic of the initial format of the underlying blockchains. Tools to do sample analyses using both SQL and a distributed map reduce with pandas are given to show what can be done for any blockchain. 

![Image description](https://raw.githubusercontent.com/velicanu/unified-blockchains/master/img/img-1.png) ![Image description](https://raw.githubusercontent.com/velicanu/unified-blockchains/master/img/img-2.png)

## Pipeline
The pipeline which takes raw blockchain data and transforms it into a JSON and SQL database is shown in the figure below. The first step runs a blockchain daemon (like Bitcoin Core for bitcoin) which downloads the raw blockchain data to the local instance. Next the blockchain data is extracted into JSON format using the API that comes with the blockchain daemon. The extracted block data in JSON format is then transformed into the unified format that is the same for all blockchains, also in JSON format. From this step each block and transaction is added into a (My)SQL database in order to leverage the power of SQL queries on this dataset. Finally the pipeline has an event based trigger which detects every time a new block is mined by querying the local daemon at regular intervals, and pulls new data all the way through the pipeline right as it becomes available. 
![Image description](https://raw.githubusercontent.com/velicanu/unified-blockchains/master/img/img-3.png)

## Sample Analyses

A straightforward analysis on this data is asking what address mined the most bitcoin. This translates to a simple SQL query as shown in the figure below. But since each blockchain has the same format in this framework, getting the top miner for Ethereum is running the exact same query, just on a different table.

![Image description](https://raw.githubusercontent.com/velicanu/unified-blockchains/master/img/img-4.png)

Another sample analysis done in this framework is counting the number of transactions per day. Since this requires scanning a large number of rows in the transaction database, using a pandas-powered map reduce query on a 6 node cluster yields the same result as a SQL query alone in about 1/6th the time as shown in the figure below. The figure shows the transactions per day for both bitcoin and ethereum, which are made with the exact same code.

![Image description](https://raw.githubusercontent.com/velicanu/unified-blockchains/master/img/img-5.png)
