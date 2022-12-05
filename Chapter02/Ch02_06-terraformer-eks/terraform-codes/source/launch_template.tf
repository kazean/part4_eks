#tfer--eks-b2c256ae-7491-c372-b8e7-b4e8c4e0a77a
resource "aws_launch_template" "init-eks-template" {
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
  #   name = "init-eks-template"
  # }

  image_id      = "ami-014ca7719d6166f28"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "init-eks-template"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = [aws_security_group.test-sg-eks-cluster.id]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU0xZWtORFFXTXJaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVVMVVSWGxPVkVFeFRsUlJlVTR4YjFoRVZFMTVUVlJGZVUxcVFURk9WRkY1VGpGdmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJTMGhpQ2l0eGRXODJWSGd2VkhwV1pTdERabGQ0UzJ4WGVsRXJZeTlCTXl0M01WVkJUWFEzUkdvd1p6VlhiemNyVTJsbU15c3dVREJJVUhWaVltVkViWE12UkZjS2RrZEtWVmxRZUZKUWIzbFhSMDk1SzBkM01YVk9ZMlYyVVhGT1RGQlVNelZsVEU5alpsUlFNMkpPU0ZVelJXTndTMHRxTnpFd04wOWlRWG8wU1hWaFV3b3JkVUpOWkU5TWNYWm5TMFJTY0U1cmRYSXdRMDlsY1RJMVNIQndNbTVRTDJoU1NIRnZORlY0WTI0MGRWVkhiVVZHUWxKb1Ewd3dVM0JYYWxCaE4xWkhDblpXU3pZelQzbzVXRkEzWlhWV1kwNXNiWE5IY1VzNFltcFZUM0ZTYTJSelkwWkJZVlJTUVZsaFpuWlZReXRYVFRFNVJWSTJaR2RyY0djck1VaE1kSFlLZVdNMlRFVnhVV2hqTjNsbk9VZG1RbE5KV21sdldtbDFiMnAxZWpZdlRuSTNWMUUwTWxWU2RVZDJMMFpwYjFKYWQwUmpNemt6YlRkbFNuaFhPVkp3WVFwRWVFY3hSbGMwUms1SFprbENNRlJPWkRFd1EwRjNSVUZCWVU1RFRVVkJkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaUGRsVlJabFphTm1sdWVYZzVSRmxEU0RoWVdWcDZXVEZVZVdSTlFUQkhRMU54UjFOSllqTUtSRkZGUWtOM1ZVRkJORWxDUVZGQ1UydGliVnBuZWtkSlRGSXZhV3BOT1hSd1JHWjBNM1ZqZVV0NFZYYzJhRWRyVjJaV2NrVkpZVGxCVFZNck4wRndlUXBOV2xkeGNVaHRSblZ6VWsxR2NtSkNXV3M0YWxCNGR6RTBXVGRYYkRCeldVMXNjbkZUVUc5TVpYaGxVR1JIYUdSVWJHMHhVVUZMVFhOWVZGSnVZemh0Q2twTVEwNXNjbVUyU1dsbFRETkxiVk5zTmtkNlZVMTBORTF5ZVVSb2NsTkNSMWhsZUhoYU1rRnJRVFl5YTBsR09WaDFWM0ZSWjBSUFVHRmFLMWxaYTJVS1V6bElRVGRpVUVwWFVVMTBNQ3RFYzBRdk9HbExWM2N3ZVRSTGIwa3ZhRlF5TlhkRlkwZzBiVXR2UjFaQ1NGcFBjbE4xVlV4eU9EQlJPRmxEY2pkbFRBcDBibGhCTTNGR0wxTmliVlJFWlVkb1MySnFVV1ZsTVdaMllVcE5lWE5DUVhSalNqaFlSeXRJYVRCeGNFVTFaWGh0VmxaYU4wRkhRWFEzTm1JMFlrMVdDbVp1VUhaTFdWWjBRVlJyVWpFeFNWUjVXVXBKY0hkeFNXZHBaeTlVVEVObEszRXdiQW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09CkFQSV9TRVJWRVJfVVJMPWh0dHBzOi8vQTg1MTNCMEFEMURCODU1MzBBODE2Q0FBQUM2NTlDMDMuZ3I3LmFwLW5vcnRoZWFzdC0yLmVrcy5hbWF6b25hd3MuY29tCks4U19DTFVTVEVSX0ROU19JUD0xMC4xMDAuMC4xMAovZXRjL2Vrcy9ib290c3RyYXAuc2ggdGVzdC1la3MtY2x1c3RlciAtLWt1YmVsZXQtZXh0cmEtYXJncyAnLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXAtaW1hZ2U9YW1pLTAxNGNhNzcxOWQ2MTY2ZjI4LGVrcy5hbWF6b25hd3MuY29tL2NhcGFjaXR5VHlwZT1PTl9ERU1BTkQsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwPXRlc3QtZWtzLW5vZGVncm91cCxyb2xlPWVrcy1ub2RlZ3JvdXAgLS1tYXgtcG9kcz0xNycgLS1iNjQtY2x1c3Rlci1jYSAkQjY0X0NMVVNURVJfQ0EgLS1hcGlzZXJ2ZXItZW5kcG9pbnQgJEFQSV9TRVJWRVJfVVJMIC0tZG5zLWNsdXN0ZXItaXAgJEs4U19DTFVTVEVSX0ROU19JUCAtLXVzZS1tYXgtcG9kcyBmYWxzZQoKLS0vLy0t"
}

#test-launch-template-yeogunna tfer--eks-b2c256ae-7491-c372-b8e7-b4e8c4e0a77a
resource "aws_launch_template" "test-launch-template-yeogunna" {
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
  #   name = "test-launch-template-yeogunna"
  # }

  image_id      = "ami-014ca7719d6166f28"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "test-launch-template-yeogunna"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = [aws_security_group.test-sg-eks-cluster.id]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU0xZWtORFFXTXJaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVVMVVSWGxPVkVFeFRsUlJlVTR4YjFoRVZFMTVUVlJGZVUxcVFURk9WRkY1VGpGdmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJTMGhpQ2l0eGRXODJWSGd2VkhwV1pTdERabGQ0UzJ4WGVsRXJZeTlCTXl0M01WVkJUWFEzUkdvd1p6VlhiemNyVTJsbU15c3dVREJJVUhWaVltVkViWE12UkZjS2RrZEtWVmxRZUZKUWIzbFhSMDk1SzBkM01YVk9ZMlYyVVhGT1RGQlVNelZsVEU5alpsUlFNMkpPU0ZVelJXTndTMHRxTnpFd04wOWlRWG8wU1hWaFV3b3JkVUpOWkU5TWNYWm5TMFJTY0U1cmRYSXdRMDlsY1RJMVNIQndNbTVRTDJoU1NIRnZORlY0WTI0MGRWVkhiVVZHUWxKb1Ewd3dVM0JYYWxCaE4xWkhDblpXU3pZelQzbzVXRkEzWlhWV1kwNXNiWE5IY1VzNFltcFZUM0ZTYTJSelkwWkJZVlJTUVZsaFpuWlZReXRYVFRFNVJWSTJaR2RyY0djck1VaE1kSFlLZVdNMlRFVnhVV2hqTjNsbk9VZG1RbE5KV21sdldtbDFiMnAxZWpZdlRuSTNWMUUwTWxWU2RVZDJMMFpwYjFKYWQwUmpNemt6YlRkbFNuaFhPVkp3WVFwRWVFY3hSbGMwUms1SFprbENNRlJPWkRFd1EwRjNSVUZCWVU1RFRVVkJkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaUGRsVlJabFphTm1sdWVYZzVSRmxEU0RoWVdWcDZXVEZVZVdSTlFUQkhRMU54UjFOSllqTUtSRkZGUWtOM1ZVRkJORWxDUVZGQ1UydGliVnBuZWtkSlRGSXZhV3BOT1hSd1JHWjBNM1ZqZVV0NFZYYzJhRWRyVjJaV2NrVkpZVGxCVFZNck4wRndlUXBOV2xkeGNVaHRSblZ6VWsxR2NtSkNXV3M0YWxCNGR6RTBXVGRYYkRCeldVMXNjbkZUVUc5TVpYaGxVR1JIYUdSVWJHMHhVVUZMVFhOWVZGSnVZemh0Q2twTVEwNXNjbVUyU1dsbFRETkxiVk5zTmtkNlZVMTBORTF5ZVVSb2NsTkNSMWhsZUhoYU1rRnJRVFl5YTBsR09WaDFWM0ZSWjBSUFVHRmFLMWxaYTJVS1V6bElRVGRpVUVwWFVVMTBNQ3RFYzBRdk9HbExWM2N3ZVRSTGIwa3ZhRlF5TlhkRlkwZzBiVXR2UjFaQ1NGcFBjbE4xVlV4eU9EQlJPRmxEY2pkbFRBcDBibGhCTTNGR0wxTmliVlJFWlVkb1MySnFVV1ZsTVdaMllVcE5lWE5DUVhSalNqaFlSeXRJYVRCeGNFVTFaWGh0VmxaYU4wRkhRWFEzTm1JMFlrMVdDbVp1VUhaTFdWWjBRVlJyVWpFeFNWUjVXVXBKY0hkeFNXZHBaeTlVVEVObEszRXdiQW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09CkFQSV9TRVJWRVJfVVJMPWh0dHBzOi8vQTg1MTNCMEFEMURCODU1MzBBODE2Q0FBQUM2NTlDMDMuZ3I3LmFwLW5vcnRoZWFzdC0yLmVrcy5hbWF6b25hd3MuY29tCks4U19DTFVTVEVSX0ROU19JUD0xMC4xMDAuMC4xMAovZXRjL2Vrcy9ib290c3RyYXAuc2ggdGVzdC1la3MtY2x1c3RlciAtLWt1YmVsZXQtZXh0cmEtYXJncyAnLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXAtaW1hZ2U9YW1pLTAxNGNhNzcxOWQ2MTY2ZjI4LGVrcy5hbWF6b25hd3MuY29tL2NhcGFjaXR5VHlwZT1PTl9ERU1BTkQsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwPXRlc3QtZWtzLW5vZGVncm91cCxyb2xlPWVrcy1ub2RlZ3JvdXAgLS1tYXgtcG9kcz0xNycgLS1iNjQtY2x1c3Rlci1jYSAkQjY0X0NMVVNURVJfQ0EgLS1hcGlzZXJ2ZXItZW5kcG9pbnQgJEFQSV9TRVJWRVJfVVJMIC0tZG5zLWNsdXN0ZXItaXAgJEs4U19DTFVTVEVSX0ROU19JUCAtLXVzZS1tYXgtcG9kcyBmYWxzZQoKLS0vLy0t"
}