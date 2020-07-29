output "zookeeper_addresses" {
  value = "${aws_instance.zk-ensemble.*.public_ip}"
}
