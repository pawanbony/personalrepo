data "aws_iam_role" "eksRole" {
  name = var.clusterRoleName
}
data "aws_iam_role" "eksNodeRole" {
  name = var.clusterNodeRoleName
}

module "securityGroup" {
  source            = "./modules/securityGroups"
  securityGroupName = var.securityGroupName
  vpcId             = var.vpcId
  tags              = var.tags
}

module "eksCluster" {
  source                 = "./modules/eksCluster"
  eksLogTypes            = var.eksLogTypes
  eksClusterName         = var.eksClusterName
  eksRoleArn             = data.aws_iam_role.eksRole.arn
  endpointPrivateAccess  = var.endpointPrivateAccess
  endpointPublicAccess   = var.endpointPublicAccess
  securityGroupId        = module.securityGroup.securityGroupId
  subnetIds              = var.subnetIds
  tags                   = var.tags
  vpcId                  = var.vpcId
}

module "nodeGroup1" {
  source                = "./modules/nodeGroups"
  eksClusterName        = var.eksClusterName
  nodeGroupName         = var.nodeGroupName
  nodeRoleArn           = data.aws_iam_role.eksNodeRole.arn
  subnetIds             = var.subnetIds
  nodeDesiredSize       = var.nodeDesiredSize
  nodeMaxSize           = var.nodeMaxSize
  nodeMinSize           = var.nodeMinSize
  capacityType          = var.capacityType
  certificate_authority = module.eksCluster.eksCertificateAuthority
  endpoint              = module.eksCluster.eksendpoint
  autoScalingGroupName  = var.autoScalingGroupName
  amiId                 = var.amiId
  instanceType          = var.instanceType
  instanceKey           = var.instanceKey
  launchTemplateName    = var.launchTemplateName
  tags                  = var.tags
  securityGroupId        = module.securityGroup.securityGroupId
}

