#cloud-config
packages:
 - curl
runcmd:
 - echo "${n}" | sudo tee -a /var/lib/zookeeper/myid
 - sudo chown -R zookeeper:zookeeper /var/lib/zookeeper/
 - echo "" | sudo tee -a /home/zookeeper/apache-zookeeper-3.6.1/conf/zoo.cfg
 - echo "server.1=zookeeper-0.zookeeper.cloud:2888:3888;2181" | sudo tee -a /home/zookeeper/apache-zookeeper-3.6.1/conf/zoo.cfg
 - echo "server.2=zookeeper-1.zookeeper.cloud:2888:3888;2181" | sudo tee -a /home/zookeeper/apache-zookeeper-3.6.1/conf/zoo.cfg
 - echo "server.3=zookeeper-2.zookeeper.cloud:2888:3888;2181" | sudo tee -a /home/zookeeper/apache-zookeeper-3.6.1/conf/zoo.cfg
 - echo "4lw.commands.whitelist=mntr,conf,ruok" | sudo tee -a /home/zookeeper/apache-zookeeper-3.6.1/conf/zoo.cfg
 - sudo runuser -u zookeeper -- /home/zookeeper/apache-zookeeper-3.6.1/bin/zkServer.sh start
