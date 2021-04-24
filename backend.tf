/*terraform {
  backend "s3" {}
}

data "terraform_remote_state" "state" {
  backend = "s3"
  config = {
    bucket               = var.s3BucketName
    workspace_key_prefix = "k8s"
    region               = "us-west-2"
    key                  = "k8s/${var.environments}/eks-dev.tfstate"
  }
}*/
