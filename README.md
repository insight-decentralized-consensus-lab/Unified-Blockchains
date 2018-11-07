# Unified-Blockchains
Data analysis toolkit for data across blockchains

## Multiple Blockchains, one data format
This repository combines data from multiple blockchains in different formats into a standard, unified format, in order to perform analyses across blockchains agnostic of the initial format of the underlying blockchains. Tools to do sample analyses using both SQL and a distributed map reduce with pandas are given to show what can be done for any blockchain. 

![Image description](https://github.com/velicanu/unified-blockchains/blob/master/img/img-1.png) ![Image description](https://github.com/velicanu/unified-blockchains/blob/master/img/img-2.png)

## Pipeline
The pipeline which takes raw blockchain data and transforms it into a JSON and SQL database is shown in the figure below. The first step runs a blockchain daemon (like Bitcoin Core for bitcoin) which downloads the raw blockchain data to the local instance. Next the blockchain data is extracted into JSON format using the API that comes with the blockchain daemon. The extracted block data in JSON format is then transformed into the unified format that is the same for all blockchains, also in JSON format. From this step each block and transaction is added into a (My)SQL database in order to leverage the power of SQL queries on this dataset. 
![Image description](https://github.com/velicanu/unified-blockchains/blob/master/img/img-3.png)
