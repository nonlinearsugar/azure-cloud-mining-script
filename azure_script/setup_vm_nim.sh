#!/usr/bin/env bash
sudo apt-get -y update       
sudo apt-get -y upgrade  
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
wget https://github.com/Beeppool/miner/releases/download/0.3.4/beepminer-0.3.4.zip
unzip beepminer-0.3.4.zip
mkdir donation
cp -r beepminer-0.3.4/* donation

pool_address1="${pool_address1:-}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes
let donation*=10

for i in `seq 1 4`;
do
    cd beepminer-0.3.4
    sudo timeout 1000m ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id
    cd ..
    if [ $donation -gt 0 ]
    then 
        cd donation 
        sudo timeout ${donation}m ./miner --wallet-address='43RH7q55kvUHpGPAiUFa7WVkcfwjTvWQZKBawb2prXq1BZY3YYHP3rAFvk8hK7ho1m7cHBWjrDzp53o2jhAbARgTT3eSWVn' --pool=pool.supportxmr.com:80 --deviceLabel=x
        cd ..
    fi
done

