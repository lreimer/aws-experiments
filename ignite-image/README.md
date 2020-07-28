# Apache Ignite AMI Image

Builds an AMI using Packer that contains a JDK with Apache Ignite installed.

## Usage

```bash
$ export AWS_ACCESS_KEY_ID="<your-accesskey>"
$ export AWS_SECRET_ACCESS_KEY="<your-secretkey>"
$ export AWS_DEFAULT_REGION="eu-central-1"

$ packer validate ignite.json
$ packer build ignite.json

...
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
eu-central-1: ami-001ff10aa7bffe840
```

## Installation

To install Apache Ignite from RPM package, try using the following commands
in the inline script. However, this RPM brings many dependencies!

```bash
    "sudo cp /tmp/ignite.repo /etc/yum.repos.d/",
    "sudo yum -y check-update || true",
    "sudo yum -y install apache-ignite",
```