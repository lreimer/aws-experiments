output "solr_addresses" {
  value = "${aws_instance.solr.*.public_ip}"
}
