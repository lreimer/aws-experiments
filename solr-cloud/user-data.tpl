#cloud-config
packages:
 - curl
runcmd:
 - echo "" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
 - echo "ZK_HOST=\"zookeeper-0.zookeeper.cloud,zookeeper-1.zookeeper.cloud,zookeeper-2.zookeeper.cloud/solr\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
 - echo "SOLR_HEAP=\"512m\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
 - echo "SOLR_HOST=\"solr-${n}.solr.cloud\"" | sudo tee -a /home/solr/solr-8.6.0/bin/solr.in.sh
