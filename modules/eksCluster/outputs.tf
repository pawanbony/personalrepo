output "eksClusterName" {
  value = aws_eks_cluster.devCluster.name
}

output "eksClusterStatus" {
  value = aws_eks_cluster.devCluster.status
}

output "eksClusterArn" {
  value = aws_eks_cluster.devCluster.arn
}

output "eksCertificateAuthority" {
  value = aws_eks_cluster.devCluster.certificate_authority[0].data
}

output "eksendpoint" {
  value = aws_eks_cluster.devCluster.endpoint
}
