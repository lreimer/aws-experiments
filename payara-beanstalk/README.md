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
```
