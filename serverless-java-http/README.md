# AWS Lambda in Java 11 with Serverless Framework

Simple Lambda function in Java 11 using the Serverless Framework to deploy.

https://docs.aws.amazon.com/lambda/latest/dg/lambda-java.html

## Build

```bash
$ ./gradlew build
```

## Deploy

```bash
$ serverless deploy
```

The expected result should be similar to:
```
Serverless: Packaging service...
Serverless: Uploading CloudFormation file to S3...
Serverless: Uploading artifacts...
Serverless: Uploading service serverless-java-http.zip file to S3 (851.55 KB)...
Serverless: Validating template...
Serverless: Updating Stack...
Serverless: Checking Stack update progress...
.................
Serverless: Stack update finished...
Service Information
service: serverless-java-http
stage: dev
region: eu-central-1
stack: serverless-java-http-dev
resources: 12
api keys:
  None
endpoints:
  GET - https://4yjyblg3uh.execute-api.eu-central-1.amazonaws.com/dev/serverless-java-http
functions:
  serverlessJavaHttp: serverless-java-http-dev-serverlessJavaHttp
layers:
  None
```

## Usage

You can now invoke the Lambda function directly and even see the resulting log via
```bash
serverless invoke --function serverlessJavaHttp --log
```

The expected result should be similar to:
```
{
    "statusCode": 200,
    "headers": {
        "Content-Type": "application/json"
    },
    "body": "{\n  \"currentTimeMillis\": 1602495523314,\n  \"message\": \"Hello Serverless Java HTTP.\"\n}",
    "base64Encoded": false
}
--------------------------------------------------------------------
START RequestId: 37fad303-5a3c-404f-bdd4-bbc4776823a5 Version: $LATEST
{
  "environment": {
    "PATH": "/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin",
    "_AWS_XRAY_DAEMON_ADDRESS": "169.254.79.2",
    "LAMBDA_TASK_ROOT": "/var/task",
    "AWS_LAMBDA_FUNCTION_MEMORY_SIZE": "512",
    "TZ": ":UTC",
    "AWS_SECRET_ACCESS_KEY": "ohtA9kfDDMGPwX9bR52SpbNA4C77OXy7KteZ1Uz2",
    "AWS_DEFAULT_REGION": "eu-central-1",
    "AWS_EXECUTION_ENV": "AWS_Lambda_java11",
    "AWS_LAMBDA_LOG_GROUP_NAME": "/aws/lambda/serverless-java-http-dev-serverlessJavaHttp",
    "LANG": "en_US.UTF-8",
    "_HANDLER": "cloud.nativ.serverless.Handler",
    "LAMBDA_RUNTIME_DIR": "/var/runtime",
    "AWS_SESSION_TOKEN": "IQoJb3JpZ2luX2VjEFIaDGV1LWNlbnRyYWwtMSJIMEYCIQCwSJUHHaAClNAp09PHkkcJGi9wxOF8kmIeXz95ahutzwIhAKNV983i/f8jxJEpbl7LwqPZEZKaY6J4+ziL8MUjzciNKvMBCIv//////////wEQAxoMNDUwODAyNTY0MzU2IgwVuLkrDNTTJEJp21UqxwGooLnRND1LO09yW3AQMSwFsA6jj3Rr2+tKt4NXlmkuxLkMtcjVcCNZuQ5B+YQcYZIyO/HsAJ054Odfn/HW6XoXpddEgEeYeo5l62ILD9mWzzyY3jsjhlWesoLCHt9flWSty3TUWOk7dyL7hpTL38/maGIcOcUHKxFnJE8tTwK3TsGSbHBGCDrDlS2+Zw4MD8ZNCrgufpdYcY7GBiefJE7D+MaSz0olJn0H37fxaB2Yq2XoTiR4qgY++YqmX30VoW7JkIr+YLZOMKLIkPwFOt8BHQton+F+CllLneG0poxbWa0ZvrOsnBTGCg98XAOV/5tmspzbbEbxgT1RIAeXiYcLfBE70M3e9bS29knX0eJunu5wZRY5/GRiR9y4D34js44URStHVVt1MSOHM2NdARR0cu54GDGA1CKgZsTCRVoVraW2GbSVjig5veh7hZG+vQBlryPSFFQMq0+qG21lqlFCg/04FZF4YeS8dEWpbr1NuJzXvH9MVDnfehgPZRUs4dlsW+WSqaBYuORuzu/vBu+XhwXHcPZmo5gUoQhZBS/Xaf2Tsx07RQfbZnCHluuonw\u003d\u003d",
    "AWS_ACCESS_KEY_ID": "ASIAWR5PNHUCFKJXZ4OQ",
    "LD_LIBRARY_PATH": "/var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib",
    "_X_AMZN_TRACE_ID": "Root\u003d1-5f842422-02732b3a5f7256ea02ce00df;Parent\u003d77d1d1702bfcabaf;Sampled\u003d0",
    "AWS_SECRET_KEY": "ohtA9kfDDMGPwX9bR52SpbNA4C77OXy7KteZ1Uz2",
    "AWS_LAMBDA_RUNTIME_API": "127.0.0.1:9001",
    "AWS_REGION": "eu-central-1",
    "AWS_LAMBDA_LOG_STREAM_NAME": "2020/10/12/[$LATEST]ef270fc0ed4d4514b9c3a8408d567161",
    "AWS_XRAY_DAEMON_ADDRESS": "169.254.79.2:2000",
    "_AWS_XRAY_DAEMON_PORT": "2000",
    "AWS_XRAY_CONTEXT_MISSING": "LOG_ERROR",
    "AWS_LAMBDA_FUNCTION_VERSION": "$LATEST",
    "AWS_ACCESS_KEY": "ASIAWR5PNHUCFKJXZ4OQ",
    "AWS_LAMBDA_FUNCTION_NAME": "serverless-java-http-dev-serverlessJavaHttp"
  },
  "context": {
    "memoryLimit": 512,
    "awsRequestId": "37fad303-5a3c-404f-bdd4-bbc4776823a5",
    "logGroupName": "/aws/lambda/serverless-java-http-dev-serverlessJavaHttp",
    "logStreamName": "2020/10/12/[$LATEST]ef270fc0ed4d4514b9c3a8408d567161",
    "functionName": "serverless-java-http-dev-serverlessJavaHttp",
    "functionVersion": "$LATEST",
    "invokedFunctionArn": "arn:aws:lambda:eu-central-1:450802564356:function:serverless-java-http-dev-serverlessJavaHttp",
    "deadlineTimeInMs": 1602495533177,
    "logger": {}
  },
  "event": {
    "isBase64Encoded": false
  }
}END RequestId: 37fad303-5a3c-404f-bdd4-bbc4776823a5
REPORT RequestId: 37fad303-5a3c-404f-bdd4-bbc4776823a5  Duration: 156.95 ms     Billed Duration: 200 ms Memory Size: 512 MB  Max Memory Used: 94 MB   Init Duration: 504.76 ms
```

Finally you can send an HTTP request directly to the endpoint using a tool like curl or HTTPie
```bash
$ http get https://XXXXXXXXXX.execute-api.eu-central-1.amazonaws.com/dev/serverless-java-http
```

The expected result should be similar to:
```json
{
    "currentTimeMillis": 1602495436266,
    "message": "Hello Serverless Java HTTP."
}
```
