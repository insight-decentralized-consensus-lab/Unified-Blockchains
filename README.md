# unified-blockchains
data analysis toolkit for data across blockchains

## Setup
Tested on a fresh Ubuntu 16.04.2 LTS install. 

First, clone this repository:
```bash
https://github.com/velicanu/unified-blockchains.git
```

AWS tools, needed for S3 archive portion. Can skip this if not using S3.
```bash
sudo apt install awscli
```


### Bitcoin
#### System Requirements
Disk space required: 
 - 400 GB for MySQL database
 - 250 GB for JSON database
 - 210 GB for bitcoin blockchain

The minimum requirement for a single machine is to be able to run and store the bitcoin blockchain (210GB), the rest can be hosted on S3 or some other distributed store. 

#### Installation and setup
```bash
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt install bitcoind
bitcoind -daemon
```
This starts the bitcoin daemon which downloads the full bitcoin blockchain. It will take a few days for this to fully sync, but we can start the pipeline to pick up new data as it becomes available.

#### Configuring the pipeline

