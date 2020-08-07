variable "aws_region" {
  description = "The AWS region things are created in"
  default = "eu-central-1"
}

variable "namespace"{
  description = "The namespace, which could be your organization name"
  default = "qaware"
}

variable "environment"{
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  default = "test"
}

variable "app_name"{
  description = "Elastic Beanstalk application name"
  default = "Payara Beanstalk"
}
