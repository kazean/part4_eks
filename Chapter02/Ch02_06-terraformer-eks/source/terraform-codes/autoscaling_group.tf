resource "aws_autoscaling_group" "tfer--eks-test-eks-nodegroup-bec27103-5b2b-f47c-e752-8f89e6b0554f" {
  # availability_zones        = ["ap-northeast-2a", "ap-northeast-2c"]
  capacity_rebalance        = "true"
  default_cooldown          = "300"
  default_instance_warmup   = "0"
  desired_capacity          = "1"
  force_delete              = "false"
  health_check_grace_period = "15"
  health_check_type         = "EC2"
  max_instance_lifetime     = "0"
  max_size                  = "1"
  metrics_granularity       = "1Minute"
  min_size                  = "1"

  mixed_instances_policy {
    instances_distribution {
      on_demand_allocation_strategy            = "prioritized"
      on_demand_base_capacity                  = "0"
      on_demand_percentage_above_base_capacity = "100"
      spot_allocation_strategy                 = "lowest-price"
      spot_instance_pools                      = "2"
    }

    launch_template {
      launch_template_specification {
        launch_template_id   = "lt-0220c5b5e5f38da23"
        launch_template_name = "eks-bec27103-5b2b-f47c-e752-8f89e6b0554f"
        version              = "1"
      }

      override {
        instance_type = "t3a.medium"
      }
    }
  }

  name                    = "eks-test-eks-nodegroup-bec27103-5b2b-f47c-e752-8f89e6b0554f"
  protect_from_scale_in   = "false"
  service_linked_role_arn = "arn:aws:iam::939823608919:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"

  tag {
    key                 = "eks:cluster-name"
    propagate_at_launch = "true"
    value               = "test-eks-cluster"
  }

  tag {
    key                 = "eks:nodegroup-name"
    propagate_at_launch = "true"
    value               = "test-eks-nodegroup"
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    propagate_at_launch = "true"
    value               = "true"
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/test-eks-cluster"
    propagate_at_launch = "true"
    value               = "owned"
  }

  tag {
    key                 = "kubernetes.io/cluster/test-eks-cluster"
    propagate_at_launch = "true"
    value               = "owned"
  }

  termination_policies      = ["AllocationStrategy", "OldestInstance", "OldestLaunchTemplate"]
  vpc_zone_identifier       = ["subnet-06303e496dfe97710", "subnet-096e892185987765c"]
  wait_for_capacity_timeout = "10m"
}
