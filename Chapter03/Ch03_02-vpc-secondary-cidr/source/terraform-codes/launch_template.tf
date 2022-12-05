resource "aws_launch_template" "tfer--eks-f4c270a4-58ba-79f7-f25a-1d78c7a8fe9d" {
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      iops                  = "0"
      # throughput            = "0"
      volume_size           = "20"
      volume_type           = "gp2"
    }
  }

  default_version         = "1"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  iam_instance_profile {
    name = "eks-f4c270a4-58ba-79f7-f25a-1d78c7a8fe9d"
  }

  image_id      = "ami-014ca7719d6166f28"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "eks-f4c270a4-58ba-79f7-f25a-1d78c7a8fe9d"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = ["sg-0823d5366861ca128"]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU0xZWtORFFXTXJaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVVMVVTWGRPVkVFelRsUkplRTlHYjFoRVZFMTVUVlJKZDAxcVFUTk9WRWw0VDBadmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJUR0pWQ2xGME0xRmlabmRwUW1Kb1JreGtabGhpWWpWSFVqWTFkR0ZoYjA1Uk5XTllOV1pIVDJZeFVFZDZhVVJJWW5SVFJIQTVZMnR2ZWxOeGNITjJLMFJ6TVVnS2VFMTBUalp4VUdGYVVXUjNVREpRVWl0VmNXMTZPRXBVTkhGWU9GSklNamwzVUc4d1ZIbFdiVEJzVDJaR2RrbGFURXBYWmxSVFExTjNkR1pSTlRoeFpnbzRORTAyZG1sTFdUZHBObEpQZEUxWVVHSndkSEYyWVZZeVkxcDRTREZwUmsxS2IyVjZiVmRpY2s5Mk9GWlVRalV3V0VsSlowZ3pMMnAzTVRkaVVWQlZDbXhGWWtRd2VFRmpibloyTURCUVlqbDBNbTlCTlZwaVMzWkljVGh3TTBWbEwzaEdWVzA0TDJ0cVVqZFJNRE13VWtwd2VITkNLMHhQYW5kakwzRlRlR2tLYUZCSVpWUjJjbkl4V0VkWkswZE1NWFp4ZFcxbFMxWjFTWGx4YnpKYWNFZGxiRnA2WldsYVN6UjJabFZHZUVsM09ESmFXa2xCTDFoUFdIaElOSFJUTndwelVpdHNPR0ZwT0V0WFkwNURiM0FyY2tKalEwRjNSVUZCWVU1RFRVVkJkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaTE1UVTRTMUJKWlVndlNIYzBXV3R4V0dWcVdtcHBkVzV3VURkTlFUQkhRMU54UjFOSllqTUtSRkZGUWtOM1ZVRkJORWxDUVZGRFVGSTRUelIwWkZCNE9HczFSbEZyYzNwcFYwRXpOMDVaTWtWRWJsQXZNakpWU1hkdmJrWnlVbUp5VW1KdlMzRllRd3BPTDFkTWRWZGxWbEF3ZFZFNVNrMDVlbGxrZUhsQk0xSkliREpYUjBOeVZrNUpSVGROTjFSdVJFTmtUVUYwWmtsNlkxVXhhR2xxVUVvd1Z6ZENPREZyQ2xkNU5VRllUakpIYWtOVFRIaE9SVU51T1U1cGJtRnNWell3UzFCS2VtaDNha1Z2ZERWcFptTmxXWGhQWjJKbmNrMHlObFJHYlZaWFRscGtZVlpZYm13S2NraE5iMnhLZUVKRmR6SjRlbmsxVFZvME9GazJPV1JIWlVwRlRucGtVbTFEV21kUFlrSTJlR1I2T0c0M2EwbEtSbUZxU1ROdlF6RTBURzVuU1daaE5BbzRiV05QUkUwNGVERTVZMmxhVVc1aVprRnpPREkxVjNSeFZFMVVSRzlrVVZWeE5sSlFaekJwUzB0WUwwSnFSM2c0T0ZsVWRYQXJOVWRPWkRodFUwRjFDaXRUWjJ0UVdsUTVkMlp3YUhjcmRXaFNTVWM0VkZGcFpqZEpkV2tyWkZCaldERktkQW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09CkFQSV9TRVJWRVJfVVJMPWh0dHBzOi8vMDVEQjI5RkE3NENBNTAxNkY0QzE4NEMyMkQ5MkM1NzcueWw0LmFwLW5vcnRoZWFzdC0yLmVrcy5hbWF6b25hd3MuY29tCks4U19DTFVTVEVSX0ROU19JUD0xMC4xMDAuMC4xMAovZXRjL2Vrcy9ib290c3RyYXAuc2ggdGVzdC1la3MtY2x1c3RlciAtLWt1YmVsZXQtZXh0cmEtYXJncyAnLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXAtaW1hZ2U9YW1pLTAxNGNhNzcxOWQ2MTY2ZjI4LGVrcy5hbWF6b25hd3MuY29tL2NhcGFjaXR5VHlwZT1PTl9ERU1BTkQsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwPXRlc3QtZWtzLW5vZGVncm91cCxyb2xlPWVrcy1ub2RlZ3JvdXAgLS1tYXgtcG9kcz0xNycgLS1iNjQtY2x1c3Rlci1jYSAkQjY0X0NMVVNURVJfQ0EgLS1hcGlzZXJ2ZXItZW5kcG9pbnQgJEFQSV9TRVJWRVJfVVJMIC0tZG5zLWNsdXN0ZXItaXAgJEs4U19DTFVTVEVSX0ROU19JUCAtLXVzZS1tYXgtcG9kcyBmYWxzZQoKLS0vLy0t"
}

#launch template2
resource "aws_launch_template" "test-launch-template-kazean" {
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      iops                  = "0"
      # throughput            = "0"
      volume_size           = "20"
      volume_type           = "gp2"
    }
  }

  default_version         = "1"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  # iam_instance_profile {
  #   name = "eks-f4c270a4-58ba-79f7-f25a-1d78c7a8fe9d"
  # }

  image_id      = "ami-014ca7719d6166f28"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "test-launch-template-kazean"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = ["sg-0823d5366861ca128"]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU0xZWtORFFXTXJaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVVMVVTWGRPVkVFelRsUkplRTlHYjFoRVZFMTVUVlJKZDAxcVFUTk9WRWw0VDBadmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJUR0pWQ2xGME0xRmlabmRwUW1Kb1JreGtabGhpWWpWSFVqWTFkR0ZoYjA1Uk5XTllOV1pIVDJZeFVFZDZhVVJJWW5SVFJIQTVZMnR2ZWxOeGNITjJLMFJ6TVVnS2VFMTBUalp4VUdGYVVXUjNVREpRVWl0VmNXMTZPRXBVTkhGWU9GSklNamwzVUc4d1ZIbFdiVEJzVDJaR2RrbGFURXBYWmxSVFExTjNkR1pSTlRoeFpnbzRORTAyZG1sTFdUZHBObEpQZEUxWVVHSndkSEYyWVZZeVkxcDRTREZwUmsxS2IyVjZiVmRpY2s5Mk9GWlVRalV3V0VsSlowZ3pMMnAzTVRkaVVWQlZDbXhGWWtRd2VFRmpibloyTURCUVlqbDBNbTlCTlZwaVMzWkljVGh3TTBWbEwzaEdWVzA0TDJ0cVVqZFJNRE13VWtwd2VITkNLMHhQYW5kakwzRlRlR2tLYUZCSVpWUjJjbkl4V0VkWkswZE1NWFp4ZFcxbFMxWjFTWGx4YnpKYWNFZGxiRnA2WldsYVN6UjJabFZHZUVsM09ESmFXa2xCTDFoUFdIaElOSFJUTndwelVpdHNPR0ZwT0V0WFkwNURiM0FyY2tKalEwRjNSVUZCWVU1RFRVVkJkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaTE1UVTRTMUJKWlVndlNIYzBXV3R4V0dWcVdtcHBkVzV3VURkTlFUQkhRMU54UjFOSllqTUtSRkZGUWtOM1ZVRkJORWxDUVZGRFVGSTRUelIwWkZCNE9HczFSbEZyYzNwcFYwRXpOMDVaTWtWRWJsQXZNakpWU1hkdmJrWnlVbUp5VW1KdlMzRllRd3BPTDFkTWRWZGxWbEF3ZFZFNVNrMDVlbGxrZUhsQk0xSkliREpYUjBOeVZrNUpSVGROTjFSdVJFTmtUVUYwWmtsNlkxVXhhR2xxVUVvd1Z6ZENPREZyQ2xkNU5VRllUakpIYWtOVFRIaE9SVU51T1U1cGJtRnNWell3UzFCS2VtaDNha1Z2ZERWcFptTmxXWGhQWjJKbmNrMHlObFJHYlZaWFRscGtZVlpZYm13S2NraE5iMnhLZUVKRmR6SjRlbmsxVFZvME9GazJPV1JIWlVwRlRucGtVbTFEV21kUFlrSTJlR1I2T0c0M2EwbEtSbUZxU1ROdlF6RTBURzVuU1daaE5BbzRiV05QUkUwNGVERTVZMmxhVVc1aVprRnpPREkxVjNSeFZFMVVSRzlrVVZWeE5sSlFaekJwUzB0WUwwSnFSM2c0T0ZsVWRYQXJOVWRPWkRodFUwRjFDaXRUWjJ0UVdsUTVkMlp3YUhjcmRXaFNTVWM0VkZGcFpqZEpkV2tyWkZCaldERktkQW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09CkFQSV9TRVJWRVJfVVJMPWh0dHBzOi8vMDVEQjI5RkE3NENBNTAxNkY0QzE4NEMyMkQ5MkM1NzcueWw0LmFwLW5vcnRoZWFzdC0yLmVrcy5hbWF6b25hd3MuY29tCks4U19DTFVTVEVSX0ROU19JUD0xMC4xMDAuMC4xMAovZXRjL2Vrcy9ib290c3RyYXAuc2ggdGVzdC1la3MtY2x1c3RlciAtLWt1YmVsZXQtZXh0cmEtYXJncyAnLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXAtaW1hZ2U9YW1pLTAxNGNhNzcxOWQ2MTY2ZjI4LGVrcy5hbWF6b25hd3MuY29tL2NhcGFjaXR5VHlwZT1PTl9ERU1BTkQsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwPXRlc3QtZWtzLW5vZGVncm91cCxyb2xlPWVrcy1ub2RlZ3JvdXAgLS1tYXgtcG9kcz0xNycgLS1iNjQtY2x1c3Rlci1jYSAkQjY0X0NMVVNURVJfQ0EgLS1hcGlzZXJ2ZXItZW5kcG9pbnQgJEFQSV9TRVJWRVJfVVJMIC0tZG5zLWNsdXN0ZXItaXAgJEs4U19DTFVTVEVSX0ROU19JUCAtLXVzZS1tYXgtcG9kcyBmYWxzZQoKLS0vLy0t"
}
