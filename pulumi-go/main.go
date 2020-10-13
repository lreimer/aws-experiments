package main

import (
	"io/ioutil"

	"github.com/pulumi/pulumi-aws/sdk/v3/go/aws/s3"
	"github.com/pulumi/pulumi/sdk/v2/go/pulumi"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		// Create an AWS resource (S3 Bucket)
		bucket, err := s3.NewBucket(ctx, "pulumi-bucket", &s3.BucketArgs{
			Website: s3.BucketWebsiteArgs{
				IndexDocument: pulumi.String("index.html"),
			},
		})
		if err != nil {
			return err
		}

		htmlContent, err := ioutil.ReadFile("site/index.html")
		if err != nil {
			return err
		}

		_, err = s3.NewBucketObject(ctx, "index.html", &s3.BucketObjectArgs{
			Acl:         pulumi.String("public-read"),
			ContentType: pulumi.String("text/html"),
			Bucket:      bucket.ID(),
			Content:     pulumi.String(string(htmlContent)),
		})
		if err != nil {
			return err
		}

		// Export the name and URL of the bucket
		ctx.Export("bucketName", bucket.ID())
		ctx.Export("bucketEndpoint", pulumi.Sprintf("http://%s", bucket.WebsiteEndpoint))

		return nil
	})
}
