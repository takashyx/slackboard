# Thanks to: http://qiita.com/saicologic/items/933e2f27b3e32c199248

set -x
set -e

BASE_DIR="$PWD/vendor/mecab"

sudo apt-get remove mecab

if [ ! -d "$BASE_DIR" ]
then
    mkdir $BASE_DIR
fi

if [ ! -f "$BASE_DIR/mecab-0.996.tar.gz" ]
then
    cd $BASE_DIR
    wget http://mecab.googlecode.com/files/mecab-0.996.tar.gz
    tar zxvf mecab-0.996.tar.gz
    cd mecab-0.996
    ./configure
    make
fi
cd $BASE_DIR/mecab-0.996
sudo make install
sudo sh -c "echo '/usr/local/lib' >> /etc/ld.so.conf"
sudo ldconfig

if [ ! -f "$BASE_DIR/mecab-ipadic-2.7.0-20070801.tar.gz" ]
then
    cd $BASE_DIR
    wget http://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz
    tar zxvf mecab-ipadic-2.7.0-20070801.tar.gz
    cd mecab-ipadic-2.7.0-20070801
    ./configure --with-charset=utf8
    make
fi
cd $BASE_DIR/mecab-ipadic-2.7.0-20070801
sudo make install