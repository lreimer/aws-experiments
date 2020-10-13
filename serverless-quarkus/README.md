# AWS Lambda with Quarkus (and Serverless Framework)

Simple Lambda function using Quarkus and Java 11. The function can be build and deployed
in JVM and also in native mode. Deployment either via shell script or Serverless framework.

More details here: https://quarkus.io/guides/amazon-lambda

The function can not be invoked via HTTP due to an unknown Cloud Front error.

## Preparation

We need to create an AWS Lambda execution role using the AWS CLI.

```bash
$ aws iam create-role --role-name lambda-execution --assume-role-policy-document file://trust-policy.json
$ aws iam attach-role-policy --role-name lambda-execution --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

$ export LAMBDA_ROLE_ARN="arn:aws:iam::450802564356:role/lambda-execution"
```

## Build and Deploy Function (JVM mode)

```bash
$ ./gradlew build
$ sam local invoke --template build/sam.jvm.yaml --event payload.json

$ export LAMBDA_ROLE_ARN="arn:aws:iam::450802564356:role/lambda-execution"
$ sh build/manage.sh create

$ cp payload.json build/
$ sh build/manage.sh invoke

# using Serverless framework
# in serverless.yaml the runtime must be set to java11
$ serverless deploy
$ serverless invoke
```

## Build and Deploy Function (Native mode)

```bash
$ ./gradlew build -Dquarkus.package.type=native -Dquarkus.native.container-build=true
$ sam local invoke --template build/sam.native.yaml --event payload.json

$ export LAMBDA_ROLE_ARN="arn:aws:iam::450802564356:role/lambda-execution"
$ sh build/manage.sh native create

$ cp payload.json build/
$ sh build/manage.sh invoke

# using Serverless framework
# in serverless.yaml the runtime must be set to provided
$ serverless deploy
$ serverless invoke --function serverlessQuarkus --log
```
