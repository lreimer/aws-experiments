# Apache Solr AMI Image

Builds an AMI using Packer that contains a JDK with Apache Solr installed.

## Usage

```bash
$ export AWS_ACCESS_KEY_ID="<your-accesskey>"
$ export AWS_SECRET_ACCESS_KEY="<your-secretkey>"
$ export AWS_DEFAULT_REGION="eu-central-1"

$ packer validate solr.json
$ packer build solr.json

...
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
eu-central-1: ami-02cc9574c2f3bd879
```
