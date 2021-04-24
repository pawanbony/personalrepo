output "eks_status" {
  value = module.eksCluster.eksClusterStatus
}

output "eks_arn" {
  value = module.eksCluster.eksClusterArn
}