output "elastic-0" {
  value = "${aws_instance.elastic.0.public_ip}"
}
output "elastic-1" {
  value = "${aws_instance.elastic.1.public_ip}"
}
output "elastic-2" {
  value = "${aws_instance.elastic.2.public_ip}"
}