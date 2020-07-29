#cloud-config
packages:
 - curl
runcmd:
 - echo "${n}" | sudo tee -a /var/lib/zookeeper/myid
 - sudo chown -R zookeeper:zookeeper /var/lib/zookeeper/