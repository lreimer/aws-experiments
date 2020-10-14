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

resource "aws_elastic_beanstalk_application" "default" {
  name        = "Payara Beanstalk"
  description = "Payara Beanstalk application created by Terraform"
}

resource "aws_elastic_beanstalk_environment" "default" {
  name                = "payara-beanstalk-${var.environment}"
  description         = "Payara Beanstalk environment created by Terraform"

  application         = aws_elastic_beanstalk_application.default.id
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.15.4 running Docker 19.03.6-ce"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t2.micro,t3.micro"
  }

}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.namespace}-${var.environment}-${uuid()}"
  description = "Payara Beanstalk application version created by Terraform"

  application = aws_elastic_beanstalk_application.default.name
  bucket      = aws_s3_bucket.app_bucket.id
  key         = aws_s3_bucket_object.app_item.id
}
