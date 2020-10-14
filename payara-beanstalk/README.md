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

When using Terraform to provision the Beanstalk infrastructure, there are several modules and resources available. Have a look at
the URLs provided under the references section.

```
$ terraform init
$ terraform plan
$ terraform apply

$ aws --region eu-central-1 elasticbeanstalk update-environment --environment-name $(terraform output env_name) --version-label $(terraform output app_version)

$ http get awseb-e-w-AWSEBLoa-A4TAOINZO7LA-825399985.eu-central-1.elb.amazonaws.com/api/jakarta.ee/8

$ http get awseb-e-w-AWSEBLoa-A4TAOINZO7LA-825399985.eu-central-1.elb.amazonaws.com/health
$ http get awseb-e-w-AWSEBLoa-A4TAOINZO7LA-825399985.eu-central-1.elb.amazonaws.com/metrics
$ http get awseb-e-w-AWSEBLoa-A4TAOINZO7LA-825399985.eu-central-1.elb.amazonaws.com/openapi
```

## References

- https://docs.aws.amazon.com/de_de/elasticbeanstalk/latest/dg/eb-cli3.html

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_application
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_application_version
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_environment

- https://medium.com/@jackmahoneynz/deploying-applications-to-elasticbeanstalk-with-terraform-6c0694558ccf
- https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application
- https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment
