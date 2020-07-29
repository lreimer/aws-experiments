#cloud-config
packages:
 - curl
perserve_hostname: true
runcmd:
 - echo "${n}" | sudo tee -a /var/lib/zookeeper/myid
 - sudo chown -R zookeeper:zookeeper /var/lib/zookeeper/