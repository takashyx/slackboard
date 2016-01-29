#!/bin/bash

# Remove mecab
sudo apt-get remove mecab

# make sure
sudo rm /usr/lib/libmecab.*
sudo ldconfig

echo "========================================================================"


mkdir -p ~/tmp

# Install mecab

cd ~/tmp
curl -O https://mecab.googlecode.com/files/mecab-0.996.tar.gz
tar zxfv mecab-0.996.tar.gz
cd mecab-0.996
./configure
make
sudo make install

echo "========================================================================"

# load mecab.so
sudo sh -c "echo '$HOME/usr/lib' >> /etc/ld.so.conf"
sudo ldconfig

echo "========================================================================"

# Install mecab-ipadic
cd ~/tmp
curl -O https://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz
tar zxfv mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801
./configure --with-charset=utf8
make
sudo make install

# add to mecabrc
sudo sh -c "echo 'dicrc = $HOME/usr/lib/mecab/dic/ipadic' >> /etc/mecabrc"

echo "========================================================================"

# Install mecab-python
cd ~/tmp
curl -O https://mecab.googlecode.com/files/mecab-python-0.996.tar.gz
pip install --user mecab-python-0.996.tar.gz

echo "========================================================================"
