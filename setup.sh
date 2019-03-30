#!/bin/bash
echo "===================SETTING UP PYSPARK=============================="
apt-get update
if [ "$1" == "master" ]; then
    echo "=====================Running setup for master server====================="
    apt-get install openssh-server openssh-client -y
    ssh-keygen -t rsa -P ""
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
else
    echo "============Running setup for slave server, will install java, scala too=============="
fi

echo "===================COPYING host-list=============================="
cat host-list >> /etc/hosts
echo "===================INSTALLING PYTHON=============================="
apt-get install python-software-properties -y
echo "===================INSTALLING JAVA, SCALA=============================="
add-apt-repository ppa:webupd8team/java
apt-get install --reinstall ca-certificates
apt-get update
apt-get install oracle-java8-installer -y
apt-get install scala -y
echo "===================INSTALLING PYTHON3-PIP, PYSPARK=============================="
apt-get install python3-pip -y
pip3 install pyspark -y
echo "===================DOWNLOADING SPARK=============================="
wget http://mirrors.estointernet.in/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
tar xvf spark-2.4.0-bin-hadoop2.7.tgz
mv spark-2.4.0-bin-hadoop2.7 /usr/local/spark
rm spark-2.4.0-bin-hadoop2.7.tgz
echo "export PATH='$PATH':/usr/local/spark/bin" >> ~/.bashrc
echo "export SPARK_HOME=/usr/local/spark/bin" >> ~/.bashrc
source ~/.bashrc
if [ "$1" == "master" ]; then
    cp /usr/local/spark/conf/spark-env.sh.template /usr/local/spark/conf/spark-env.sh
    echo "export SPARK_MASTER_HOST='$2'" >> /usr/local/spark/conf/spark-env.sh
    echo "export PYSPARK_DRIVER_PYTHON=python3" >> /usr/local/spark/conf/spark-env.sh
    echo "export PYSPARK_PYTHON=/usr/bin/python3" >> /usr/local/spark/conf/spark-env.sh

    echo "$JAVA_HOME could change"
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> /usr/local/spark/conf/spark-env.sh
    cp slaves /usr/local/spark/conf
    echo "========================Setup Complete=============================="
else
    echo "========================Setup Complete=============================="

fi
source ~/.bashrc
