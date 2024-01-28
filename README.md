# tf-minio
Terraform Script that deploys minio in a self hosted kubernetes cluster

# Needs
- S3 Bucket
- Availability to deploy kubernetes objects in a cluster
- Terraform installed
- In this case the github runner will be self hosted
- openebs deployed in the cluster
- Traefik as the IngressController

# Workflow
- Terraform will push and pull the tfstate file to an S3 bucket whenever the github action is triggered
- Whenever terraform detects theres a change in the infrastructure it will match or try to match the current state with the desired state
