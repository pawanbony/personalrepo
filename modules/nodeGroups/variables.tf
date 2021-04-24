variable "subnetIds" {
  type        = list(any)
  description = "Enter subnet ids"
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
variable "eksClusterName" {
  type        = string
  description = "Enter cluster name"
}
variable "capacityType" {
  type        = string
  description = "Enter spot or on-demand"
}
variable "certificate_authority" {
  description = "Enter Ceritificate authority of EKS Cluster"
}

variable "endpoint" {
  description = "eks endpoint"
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

variable "nodeRoleArn" {
  type        = string
  description = "Enter Service linked role arn"
}
variable "tags" {
  type        = map(string)
  description = "Enter the tags for the resources"
}

variable "securityGroupId" {
  type        = string
  description = "Enter Security Group Id"
}