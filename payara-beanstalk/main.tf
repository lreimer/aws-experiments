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

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.namespace}-payara-beanstalk"
  acl    = "private"
}

resource "aws_s3_bucket_object" "app_item" {
  key    = "${var.environment}/payara-beanstalk-${uuid()}"
  bucket = aws_s3_bucket.app_bucket.id
  source = "Dockerrun.aws.json"
}

module "elastic_beanstalk_application" {
  source = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=master"

  namespace = var.namespace
  stage     = var.environment
  name      = var.app_name
}

module "elastic_beanstalk_environment" {
  source = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=master"

  namespace                          = var.namespace
  stage                              = var.environment
  name                               = var.app_name
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name

  vpc_id              = data.aws_vpc.default.id
  region              = var.aws_region
  availability_zone_selector         = "Any 3"

  instance_type           = "t3.small"

  loadbalancer_subnets = data.aws_subnet_ids.default.ids 
  application_subnets = data.aws_subnet_ids.default.ids

  solution_stack_name = "64bit Amazon Linux 2018.03 v2.15.2 running Docker 19.03.6-ce"

  wait_for_ready_timeout = "5m"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.namespace}-${var.environment}-${uuid()}"
  application = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  bucket      = aws_s3_bucket.app_bucket.id
  key         = aws_s3_bucket_object.app_item.id
}
