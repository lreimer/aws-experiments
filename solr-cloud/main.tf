provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile = "default"
  region = var.aws_region
  version = "~> 2.70"
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
  name        = "Solr SSH"
  vpc_id      = data.aws_vpc.default.id

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
  
  name = "Solr"
  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "solr" {
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"
    values = [
      "apache-solr-8.6.0-*",
    ]
  }
}

data "template_file" "user_data" {
  count = var.size
  template = file("user-data.tpl")
  vars = {
    n = count.index
  }
}

resource "aws_instance" "solr" {
  count = var.size
  ami = data.aws_ami.solr.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = var.key_name

  subnet_id = tolist(data.aws_subnet_ids.default.ids)[count.index]
  vpc_security_group_ids = [module.solr_security_group.this_security_group_id, aws_security_group.ssh.id]

  user_data = data.template_file.user_data[count.index].rendered

  tags = {
    Name = "solr-${count.index+1}"
    Service   = "Solr"
    Environment = "DEV"
  }
}

locals {
  domains = [
      for i in range(var.size ) : "solr-${i}.solr.cloud"
  ]
}

resource "aws_route53_zone" "solr" {
  name = "solr.cloud"

  vpc {
    vpc_id = data.aws_vpc.default.id
  }
}

resource "aws_route53_record" "solr-dns" {
  count = var.size
  zone_id = aws_route53_zone.solr.id
  name = local.domains[count.index]
  type = "A"
  ttl = "300"
  records = [aws_instance.solr[count.index].private_ip]
}