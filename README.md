# Running Pyspark on a cluster

- Create a pool of servers to start with. Lets say we have 4 servers. We will make one as the master and other two as slave.

- In the `host-list` file mention the ip address and nick names for the servers.
e.g
```
>> host-list file template
138.68.52.140 master
138.68.253.51 slave01
165.227.51.191 slave02
104.248.179.44 slave03
```

- In the slaves file, only mention the nick names you have choosen.
e.g
```
>> slaves file template
master
slave01
slave02
slave03
```

- Assuming you have the clone of this repository all over you servers.

- run the following on master`./setup.sh master IP` 
e.g
`./setup.sh master 138.68.52.140`

- on slaves run `./setup.sh`

- Note: You may have to run `chmod +x setup.sh`

- Copy the content of .ssh/id_rsa.pub (of master) to .ssh/authorized_keys (of all the slaves).

- To Check the connection run `ssh slave01`

- sample test file: https://norvig.com/big.txt

- code:
```
from pyspark import SparkContext
sc = SparkContext(master = "spark://138.68.52.140:7077")
# sc.stop()

def getContent(w):
    return w.lower()
fileProcess = 'big.txt'
rdd = sc.textFile(fileProcess)
rdd1 = rdd.map(getContent)
rdd1.take(-1)
~

```

- To use spark-submit, run `source ~/.bashrc`
