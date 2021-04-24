data "aws_iam_role" "serviceLinkedRole" {
  name = "AWSServiceRoleForAutoScaling"
}

/*data "aws_iam_role" "serviceLinkedRole" {
  name = "AWSServiceRoleForAmazonEKSNodegroup"
}
resource "aws_iam_role" "example" {
  name = "eks-node-group-example"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.example.name
}*/
resource "aws_eks_node_group" "nodegrp1" {
  cluster_name    = var.eksClusterName
  node_group_name = var.nodeGroupName
  node_role_arn   = var.nodeRoleArn
  subnet_ids      = var.subnetIds
  lifecycle {
    ignore_changes = [
      scaling_config.0.desired_size,
    ]
  }
  scaling_config {
    desired_size = var.nodeDesiredSize
    max_size     = var.nodeMaxSize
    min_size     = var.nodeMinSize
  }
  capacity_type = var.capacityType
  launch_template {
    id      = aws_launch_template.nodeLaunchTemplate.id
    version = aws_launch_template.nodeLaunchTemplate.latest_version
  }
    /*(depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]*/
}

locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${var.endpoint}' --b64-cluster-ca '${var.certificate_authority}' '${var.eksClusterName}'
USERDATA

}
# aws_launch_template.nodeLaunchTemplate:
resource "aws_launch_template" "nodeLaunchTemplate" {
  default_version         = 1
  disable_api_termination = false
  image_id                = var.amiId
  instance_type           = var.instanceType
  key_name                = var.instanceKey
  name                    = var.launchTemplateName
  tags                    = var.tags
  user_data               = base64encode(local.demo-node-userdata)
  vpc_security_group_ids  = [var.securityGroupId]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      iops                  = 0
      volume_size           = 20
      volume_type           = "gp2"
    }
  }

  metadata_options {
    http_put_response_hop_limit = 2
    http_endpoint               = "enabled"
  }
}

# aws_autoscaling_group.web:
resource "aws_autoscaling_group" "eksAutoScaling" {
  default_cooldown          = 300
  desired_capacity          = 2
  enabled_metrics           = []
  health_check_grace_period = 15
  health_check_type         = "EC2"
  load_balancers            = []
  max_instance_lifetime     = 0
  max_size                  = 5
  metrics_granularity       = "1Minute"
  min_size                  = 2
  name                      = var.autoScalingGroupName
  protect_from_scale_in     = false
  service_linked_role_arn   = data.aws_iam_role.serviceLinkedRole.arn
  suspended_processes       = []
  target_group_arns         = []
  vpc_zone_identifier       = ["subnet-01c83fccd1a8250cc","subnet-063aa9eecbffda074"]
  termination_policies = [
    "AllocationStrategy",
    "OldestLaunchTemplate",
    "OldestInstance",
  ]

  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy            = "prioritized"
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "capacity-optimized"
      spot_instance_pools                      = 0
    }

    launch_template {
      launch_template_specification {
        launch_template_id   = aws_launch_template.nodeLaunchTemplate.id
        launch_template_name = aws_launch_template.nodeLaunchTemplate.name
        version              = "1"
      }

      override {
        instance_type = "t3.medium"
      }
    }
  }
  tag {
    key                 = "eks:cluster-name"
    propagate_at_launch = true
    value               = "eks-infra-cluster"
  }
  tag {
    key                 = "eks:nodegroup-name"
    propagate_at_launch = true
    value               = "worker-nodes"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/eks-infra-cluster"
    propagate_at_launch = true
    value               = "owned"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    propagate_at_launch = true
    value               = "true"
  }
  tag {
    key                 = "kubernetes.io/cluster/eks-infra-cluster"
    propagate_at_launch = true
    value               = "owned"
  }
  tag {
    key = "kubernetes.io/devCluster/${var.eksClusterName}"
    value = "owned"
    propagate_at_launch = true
    }

  timeouts {}
}