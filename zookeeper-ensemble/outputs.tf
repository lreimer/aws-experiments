output "zookeeper_addresses" {
  value = "${module.zk-ensemble.public_ip}"
}
