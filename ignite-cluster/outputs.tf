output "ignite_addresses" {
  value = "${aws_instance.ignite.*.public_ip}"
}
