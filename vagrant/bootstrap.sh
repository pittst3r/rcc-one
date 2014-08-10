#!/usr/bin/env bash

sudo apt-get -y update
sudo apt-get -y install git autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libsqlite3-dev curl
curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
gunzip ruby-2.1.2.tar.gz
tar -xf ruby-2.1.2.tar
rm ruby-2.1.2.tar
cd ruby-2.1.2
./configure
make
sudo make install
cd ../
rm -rf ruby-2.1.2
sudo gem install bundler
