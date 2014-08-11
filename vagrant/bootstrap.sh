#!/usr/bin/env bash

# Install some prerequisites
sudo apt-get -y update
sudo apt-get -y install git autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libsqlite3-dev curl libfontconfig libfreetype6 libfreetype6-dev

# Install ruby
curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
tar -xzvf ruby-2.1.2.tar
rm ruby-2.1.2.tar
cd ruby-2.1.2
./configure
make
sudo make install
cd ../
rm -rf ruby-2.1.2

# Install phantomjs
curl -OL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-i686.tar.bz2
tar -xjvf phantomjs-1.9.7-linux-i686.tar.bz2
rm phantomjs-1.9.7-linux-i686.tar.bz2
sudo mv phantomjs-1.9.7-linux-i686/bin/phantomjs /usr/local/bin/
rm -rf phantomjs-1.9.7-linux-i686/

# Install node
curl -OL http://nodejs.org/dist/v0.10.30/node-v0.10.30.tar.gz
tar -xzvf node-v0.10.30.tar.gz
rm node-v0.10.30.tar.gz
cd node-v0.10.30
python ./configure
make
sudo make install
cd ..
rm -rf node-v0.10.30
sudo npm install -g bower

# Install bundler
sudo gem install bundler
