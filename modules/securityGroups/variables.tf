variable "securityGroupName" {
  type        = string
  description = "Enter vpc Id"
}

variable "vpcId" {
  type        = string
  description = "Enter vpcId"
}

variable "tags" {
  type        = map(string)
  description = "Enter tags for the Resouces"
}