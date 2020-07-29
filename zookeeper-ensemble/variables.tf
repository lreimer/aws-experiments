variable "aws_region" {
  description = "The AWS region things are created in"
  default = "eu-central-1"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/zookeeper.pub
DESCRIPTION
  default = "zookeeper.pub"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "zookeeper"
}

variable "size" {
  type = number
  description = "The Zookeeper ensemble size"
  default = "3"
}