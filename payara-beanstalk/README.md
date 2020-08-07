# Payara Micro on Elastic Beanstalk with Terraform

Creates a Elastic Beanstalk application and deploys a micro service using Jakarta EE 8 with Java 11 on Payara 5.201.

## Using the CLI

For this, you need to have the Elastic Beanstalk CLI installed on your machine.

```bash
$ eb init -r eu-central-1 -p docker payara-beanstalk
$ eb create payara-beanstalk-test
$ eb open
$ eb terminate payara-beanstalk-test --all --force
```

## Using Terraform

With Terraform we use the Beanstalk modules provided by CloudPosse to deploy the Docker image for the demo application.

```
$ terraform init
$ terraform plan
$ terraform apply

$ aws --region eu-central-1 elasticbeanstalk update-environment --environment-name $(terraform output env_name) --version-label $(terraform output app_version)
```

## References
- https://medium.com/@jackmahoneynz/deploying-applications-to-elasticbeanstalk-with-terraform-6c0694558ccf
- https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application
- https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment

## CloudPosse Modules

```
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

  loadbalancer_subnets = data.aws_subnet_ids.default.ids 
  application_subnets = data.aws_subnet_ids.default.ids

  solution_stack_name = "64bit Amazon Linux 2018.03 v2.15.2 running Docker 19.03.6-ce"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.namespace}-${var.environment}-${uuid()}"
  application = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  bucket      = aws_s3_bucket.app_bucket.id
  key         = aws_s3_bucket_object.app_item.id
}
```