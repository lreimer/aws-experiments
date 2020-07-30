provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = var.aws_region
  version                 = "~> 2.70"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "ssh" {
  name   = "Ignite SSH"
  vpc_id = data.aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "solr_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/solr"
  version = "~> 3.0"

  name   = "Solr"
  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "ignite" {
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"
    values = [
      "apache-ignite-2.8.1-*",
    ]
  }
}

data "template_file" "user_data" {
  count    = var.size
  template = file("user-data.tpl")
  vars = {
    n = count.index
  }
}

resource "aws_instance" "ignite" {
  count                       = var.size
  ami                         = data.aws_ami.ignite.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = var.key_name

  subnet_id              = tolist(data.aws_subnet_ids.default.ids)[count.index]
  vpc_security_group_ids = [module.solr_security_group.this_security_group_id, aws_security_group.ssh.id]

  user_data = data.template_file.user_data[count.index].rendered

  tags = {
    Name        = "ignite-${count.index + 1}"
    Service     = "Ignite"
    Environment = "DEV"
  }
}
