# Payara Micro on Elastic Kubernetes Service (EKS)

Creates an EKS cluster and deploys a micro service using Jakarta EE 8 with Java 11 on Payara 5.201.

## Using the CLI

For this, you need to have the AWS CLI and also the `ekscli` CLI installed on your machine.

```bash
# create an EKS cluster with Fargate support
$ eksctl create cluster --name payara-eks --region eu-central-1 --version 1.17 --fargate --without-nodegroup --alb-ingress-access --auto-kubeconfig

$ eksctl utils associate-iam-oidc-provider --cluster payara-eks --approve
$ curl -o alb-ingress-iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/iam-policy.json
$ aws iam create-policy --policy-name ALBIngressControllerIAMPolicy --policy-document file://alb-ingress-iam-policy.json

$ curl -o alb-ingress-rbac-role.yaml -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/rbac-role.yaml
$ kubectl apply -f alb-ingress-rbac-role.yaml

# use the service ploicy arn from previous command, like arn:aws:iam::450802564356:policy/ALBIngressControllerIAMPolicy
$ eksctl create iamserviceaccount \
    --region eu-central-1 \
    --name alb-ingress-controller \
    --namespace kube-system \
    --cluster payara-eks \
    --attach-policy-arn arn:aws:iam::450802564356:policy/ALBIngressControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve

$ curl -o alb-ingress-controller.yaml https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/alb-ingress-controller.yaml
$ kubectl apply -f alb-ingress-controller.yaml

# we need to insert the VPC ID into the ingress controller definition
$ aws ec2 describe-vpcs
$ kubectl edit deployment.apps/alb-ingress-controller -n kube-system
# change aws-vpc-id args - --aws-vpc-id=vpc-069cf6e5990517074

$ kubectl apply -f microservice.yaml
$ kubectl get pods,deployments,ingresses

```

## Using Terraform

Alternatively, the EKS cluster can be created using Terraform and the EKS module from AWS.

```bash
# TODO
```

## References

- https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html#gs-console-install-awscli
- https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html#installing-eksctl

- https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html
- https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
- https://docs.aws.amazon.com/eks/latest/userguide/load-balancing.html

- https://github.com/terraform-providers/terraform-provider-aws/examples/eks-getting-started
- https://aws.amazon.com/de/blogs/startups/from-zero-to-eks-with-terraform-and-helm/
- https://medium.com/@Joachim8675309/building-amazon-eks-with-terraform-5cbecf68606b
