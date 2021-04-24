variable "s3BucketName" {
  type        = string
  description = "Enter S3 Bucket Name for backend Configuration"
}

variable "environments" {
  type        = string
  description = "Enter environment on which eks will deploy"
}

variable "eksClusterName" {
  type        = string
  description = "eks-cluster-test"
}

variable "clusterRoleName" {
  type        = string
  description = "Enter cluster role name"
}

variable "clusterNodeRoleName" {
  type        = string
  description = "Enter cluster node role name"
}

variable "endpointPrivateAccess" {
  type        = string
  description = "Enter endpoint private accesss to be enabled or not"
}

variable "endpointPublicAccess" {
  type        = string
  description = "Enter endpoint private accesss to be enabled or not"
}

variable "vpcId" {
  type        = string
  description = "Enter vpc id"
}

variable "subnetIds" {
  type        = list(any)
  description = "Enter subnet ids"
}

variable "securityGroupName" {
  type        = string
  description = "Enter security group name"
}

variable "capacityType" {
  type        = string
  description = "Enter spot or on-demand"
}

variable "tags" {
  type        = map(string)
  description = "Enter the tags for the resources"
}

variable "nodeGroupName" {
  type        = string
  description = "Enter node group name"
}

variable "nodeDesiredSize" {
  description = "Enter node desired size"
}

variable "nodeMaxSize" {
  description = "Enter max nodes"
}

variable "nodeMinSize" {
  description = "Enter min nodes"
}

variable "autoScalingGroupName" {
  type        = string
  description = "Enter AutoScalingGroup name"
}

variable "amiId" {
  type        = string
  description = "Enter AMI ID to launch Spot instances."
}

variable "instanceType" {
  type        = string
  description = "Enter instance Size"
}

variable "instanceKey" {
  type        = string
  description = "Enter instance Key"
}

variable "launchTemplateName" {
  type        = string
  description = "Enter Launch Template"
}

variable "eksLogTypes" {
  type        = list(any)
  description = "Enter logtypes for EKS Cluster"
}