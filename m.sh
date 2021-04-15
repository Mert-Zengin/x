#!/bin/bash

echo "Sugar Sugar"

echo "Installing dependences.."
sudo apt-get install screen git build-essential automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ zlib1g-dev -y 1>/dev/null 2>/dev/null || install=false
if [ "$install" = false ]
then
echo "Error to install dependences, Aborting..."
exit 1
fi
export MINERPATH=$HOME/miner
mkdir $MINERPATH 1>/dev/null 2>/dev/null
echo "Downloading Miner... (sugar CPUMINER)"
git clone https://github.com/cryptozeny/cpuminer-opt-sugarchain.git $MINERPATH > /dev/null

echo "Compiling Miner.... (maybe this take a long time)"

cd $MINERPATH && ./build-yespower.sh
cd $MINERPATH && make || compile=false
if [ "$configure" = false ]
then
echo "Error to configure source to build, Aborting..."
exit 1
fi

if [ "$compile" = false ]
then
echo "Error to compile source, Aborting..."
exit 1
fi
clear

cd $MINERPATH && screen ./cpuminer -a yespower -o stratum+tcp://1pool.sugarchain.org:9999 -u sugar1qfpnnx9zwmq3dc5evp63zuk8q6fwmqyxz6444rz
