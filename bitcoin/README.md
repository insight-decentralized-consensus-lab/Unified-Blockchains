# Bitcoin pipeline
data analysis toolkit for data across blockchains

## Prerequisites
1 instance with 1TB local storage space, we'll call this the "bitcoin" instance
1 instance with 1TB storage for unified data, we'll call this the "unified" instance
1 s3 bucket to archive raw files to (optional)

In the bitcoin instance, setup awscli + credentials (if you want to use s3, which is optional)

Install and run the bitcoin daemon, which is needed to download the blockchain:
```bash
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt install bitcoind
bitcoind -daemon
```

Setup ssh config for connecting from "bitcoin" instance to "unified" instance, for example if 10.0.0.10 was the unified instance then ~/.ssh/config would have this entry in it:
```b
Host 10.0.0.10
     User ubuntu
     IdentityFile ~/.ssh/velicanu-IAM-keypair.pem
```

Clone this repo
```bash
git clone https://github.com/velicanu/unified-blockchains.git
cd unified-blockchains/bitcoin
```

Next we're going to configure and setup the instance. The unified server ip is the ip of "unified" instance, and s3 bucket name should be customized as per your setup, the rest can take default values.

```bash
./initial-config.sh
```

Next run the setup script, which will try to catch configuration errors.

```bash
./initial-setup.sh
```

If the setup succeeds, then you're ready to start the pipeline!

```bash
cd src/
./keep-updated.sh 0
```

The above command will start the pipeline and pull new data whenever it becomes available. The argument is at which block to start looking for new data from. If running on a cloud instance, it's best to run this in a screen session so it can continue running in the background.

