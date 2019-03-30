#!/bin/bash
apt-get update
if [ "$1" == "master" ]; then
    echo "Running setup for master server"
    apt-get install openssh-server openssh-client
    ssh-keygen -t rsa -P ""
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
else
    echo "Running setup for slave server, will install java, scala too"
fi

cat host-list >> /etc/hosts
apt-get install python-software-properties
add-apt-repository ppa:webupd8team/java
# apt-get install --reinstall ca-certificates
apt-get install oracle-java8-installer
apt-get install scala

wget http://mirrors.estointernet.in/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
tar xvf spark-2.4.0-bin-hadoop2.7.tgz
mv spark-2.4.0-bin-hadoop2.7 /usr/local/spark
echo "export PATH='$PATH':/usr/local/spark/bin" >> ~/.bashrc
if [ "$1" == "master" ]; then
    cp /usr/local/spark/conf/spark-env.sh.template /usr/local/spark/conf/spark-env.sh
    echo "export SPARK_MASTER_HOST='$2'" >> /usr/local/spark/conf/spark-env.sh
    echo "export JAVA_HOME=$JAVA_HOME" >> /usr/local/spark/conf/spark-env.sh
    cp slave /usr/local/spark/conf
    echo "Setup Complete"
else
    echo "Setup Complete"

fi

