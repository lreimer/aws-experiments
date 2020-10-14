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
  name   = "Elasticsearch SSH"
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

  tags = {
    Name = "Elasticsearch SSH"
  }
}

resource "aws_security_group" "elastic" {
  name   = "Elastic"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Elasticsearch"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "elastic" {
  most_recent = true

  owners = ["self"]

  filter {
    name = "name"
    values = [
      "elasticsearch-7.9.2-*",
    ]
  }
}

data "template_file" "user_data" {
  count    = var.size
  template = file("user-data.tpl")
  vars = {
    n = count.index
    region = var.aws_region
  }
}

resource "aws_iam_role" "elasticsearch" {
  name               = "elasticsearch-discovery-role"
  assume_role_policy = file("role.json")
}

resource "aws_iam_role_policy" "elasticsearch" {
  name   = "elasticsearch-discovery-policy"
  policy = file("policy.json")
  role   = aws_iam_role.elasticsearch.id
}

resource "aws_iam_instance_profile" "elasticsearch" {
  name = "elasticsearch-discovery-profile"
  role = aws_iam_role.elasticsearch.name
}

resource "aws_instance" "elastic" {
  count                       = var.size
  ami                         = data.aws_ami.elastic.id
  
  iam_instance_profile        = aws_iam_instance_profile.elasticsearch.name
  
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  key_name                    = var.key_name

  subnet_id              = tolist(data.aws_subnet_ids.default.ids)[count.index]
  vpc_security_group_ids = [aws_security_group.elastic.id, aws_security_group.ssh.id]

  user_data = data.template_file.user_data[count.index].rendered

  tags = {
    Name        = "elasticsearch-${count.index + 1}"
    Service     = "Elasticsearch"
    Version     = "7.9.2"
    Role        = "master"
    Environment = "dev"
  }
}
