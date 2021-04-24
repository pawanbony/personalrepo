variable "eksLogTypes" {
  type        = list(any)
  description = "Enter list of log Types required"
}

variable "eksClusterName" {
  type        = string
  description = "Enter EKS Cluster Name"
}

variable "eksRoleArn" {
  type        = string
  description = "Enter EKS Cluster EKS Role ARN"
}

variable "tags" {
  type        = map(string)
  description = "Enter tags for the resources."
}

variable "endpointPrivateAccess" {
  type        = string
  description = "Enter endpoint private accesss to be enabled or not"
}
variable "endpointPublicAccess" {
  type        = string
  description = "Enter endpoint private accesss to be enabled or not"
}

variable "subnetIds" {
  type        = list(any)
  description = "Enter Subnet Id"
}

variable "securityGroupId" {
  type        = string
  description = "Enter Security Group Id"
}

variable "vpcId" {
  type        = string
  description = "Enter vpc id"
}
