#cloud-config
packages:
 - curl
runcmd:
 - sudo export ZK_HOST=zookeeper-0.zookeeper.cloud,zookeeper-1.zookeeper.cloud,zookeeper-2.zookeeper.cloud/solr
 - sudo /home/solr/solr-8.6.0/bin/solr /solr -z zookeeper-0.zookeeper.cloud
