resource "aws_launch_template" "tfer--eks-bec27103-5b2b-f47c-e752-8f89e6b0554f" {
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      delete_on_termination = "true"
      iops                  = "0"
      throughput            = "0"
      volume_size           = "20"
      volume_type           = "gp2"
    }
  }

  default_version         = "1"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  iam_instance_profile {
    name = "eks-bec27103-5b2b-f47c-e752-8f89e6b0554f"
  }

  image_id      = "ami-014ca7719d6166f28"
  instance_type = "t3a.medium"

  metadata_options {
    http_put_response_hop_limit = "2"
  }

  name = "eks-bec27103-5b2b-f47c-e752-8f89e6b0554f"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
    security_groups    = ["sg-0d45621786b1fe7a3"]
  }

  tags = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  tags_all = {
    "eks:cluster-name"   = "test-eks-cluster"
    "eks:nodegroup-name" = "test-eks-nodegroup"
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiB0ZXh0L3gtc2hlbGxzY3JpcHQ7IGNoYXJzZXQ9InVzLWFzY2lpIgojIS9iaW4vYmFzaApzZXQgLWV4CkI2NF9DTFVTVEVSX0NBPUxTMHRMUzFDUlVkSlRpQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENrMUpTVU0xZWtORFFXTXJaMEYzU1VKQlowbENRVVJCVGtKbmEzRm9hMmxIT1hjd1FrRlJjMFpCUkVGV1RWSk5kMFZSV1VSV1VWRkVSWGR3Y21SWFNtd0tZMjAxYkdSSFZucE5RalJZUkZSSmVVMVVTWGRPVkVWNFRWUnJNVTVHYjFoRVZFMTVUVlJKZDAxcVJYaE5WR3N4VGtadmQwWlVSVlJOUWtWSFFURlZSUXBCZUUxTFlUTldhVnBZU25WYVdGSnNZM3BEUTBGVFNYZEVVVmxLUzI5YVNXaDJZMDVCVVVWQ1FsRkJSR2RuUlZCQlJFTkRRVkZ2UTJkblJVSkJUVXR6Q2xGRFJsZ3hOazl1VHpkVVZrWlpXVzVETUV0dUwyOUJhVmROVm5sUE56VnFia0ZyU2xrckwzUnpNV2hwVlM5SU9GQkRWalYxZUZkQlJXVjBWRll2YzBjS1FVVkRVbVpGVERneVp6WktielJ1TUZjeFJWTTNlbmRCWmtnNFJIbG5ZWGRXV1cxSlZrRmtTa2QyT0V4SlZVMWtVMFF5Y25abGJISXhWMFI0ZGxOT1RRb3hOMHRETDFKSU9TdG1iamgzZGxwNVVqVldSWG80WTNoWFZWQnNTVTFwYzA5aWN6TjBNVXhrYVhVMFQwbzRUa0o2U1c5M1ZtVklZMWRKWVZKVU1EUk5DbEl2UzFFMmJEWnhiM0pvUmpSU1UydHVTbk5xVTFVM2NrdHpLMDFpVjA5dlNrSm1UM00xVDI5RFMwdHlVbm8xWjJGcGMxZDBjSEI2T1VsbFNqVTVVbWNLVkhObWNEZFliVEozYVVZeVlqaHlkWE5vV2tGc1kzbGhabmQ0VEU5aVpUa3hhblFyWkUxelJTOU5kMHRCU2pSb1drUnpZMEl6WVd0cGQyVmtXVkZZVEFveWJHOVpOMEk1TDFoWFkyNUdhMnhzU2tjd1EwRjNSVUZCWVU1RFRVVkJkMFJuV1VSV1VqQlFRVkZJTDBKQlVVUkJaMHRyVFVFNFIwRXhWV1JGZDBWQ0NpOTNVVVpOUVUxQ1FXWTRkMGhSV1VSV1VqQlBRa0paUlVaRGVHczFlR2huWVRkWU1HcDFZemhvUVZFNGIzbFVLM2RXTXpWTlFUQkhRMU54UjFOSllqTUtSRkZGUWtOM1ZVRkJORWxDUVZGQldFUmhTakpPS3pkbmJqRnFLMkUyU1haSmFWRTVjMGRPVEZKQ1FrbGFVSGRyUzNsRlNFcFpMMjFqY2s4NFdsWnlOUXBITW5SU1dHNDNSMDVDWW5seEsyUjNZMFJRV0hocGEya3hPWEZFZUV4b2IyVjRjRmRrUmpkWVFURTBjM2N2V0M5a01HWllPQzlPU205bEsyTlNjbVZvQ2tKNWNtSlViRkZ1TW0wNEx5dHBjbFpzV1VSMVRVZDJjelZqYzNCYVNWaDRRbTlIVjFCaU5UTXdaMjVNTnpWalNrMVBiVUZGT1U5dWVVWlliRkp0T0hnS1FtVTVWV2N6UTBzMGFtUk5NakZWVVZCa1N6SjVURk1yY1RSTlRHZDJWbVZVTm1rMGMxTXdhMmRGVjNCa1RVWnNaV3R6YTFSSlNtNTNWREV3VkVWSFFRbzBOVTR2YkVOaFkySmplVGgxWjJOMGVtOVBSMnBKWjBWMWVXaFpRbU41WWpReFJuUnhlV05hUXk4NGVHMUNSMDVsTlVSWmFFSlFlV0ZKTWxacFNVRXhDblJvTURGSU4zUmFPV1kyYm1kNU1IWk5NbXhGYzJGTlVFYzBXR2hTTWsxS1FteEtjUW90TFMwdExVVk9SQ0JEUlZKVVNVWkpRMEZVUlMwdExTMHRDZz09CkFQSV9TRVJWRVJfVVJMPWh0dHBzOi8vMUFFNDBEMkQxNzM1NEIyQjNGNjNFMDk4MDEyRkJGOUQuZ3I3LmFwLW5vcnRoZWFzdC0yLmVrcy5hbWF6b25hd3MuY29tCks4U19DTFVTVEVSX0ROU19JUD0xMC4xMDAuMC4xMAovZXRjL2Vrcy9ib290c3RyYXAuc2ggdGVzdC1la3MtY2x1c3RlciAtLWt1YmVsZXQtZXh0cmEtYXJncyAnLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9ub2RlZ3JvdXAtaW1hZ2U9YW1pLTAxNGNhNzcxOWQ2MTY2ZjI4LGVrcy5hbWF6b25hd3MuY29tL2NhcGFjaXR5VHlwZT1PTl9ERU1BTkQsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwPXRlc3QtZWtzLW5vZGVncm91cCxyb2xlPWVrcy1ub2RlZ3JvdXAgLS1tYXgtcG9kcz0xNycgLS1iNjQtY2x1c3Rlci1jYSAkQjY0X0NMVVNURVJfQ0EgLS1hcGlzZXJ2ZXItZW5kcG9pbnQgJEFQSV9TRVJWRVJfVVJMIC0tZG5zLWNsdXN0ZXItaXAgJEs4U19DTFVTVEVSX0ROU19JUCAtLXVzZS1tYXgtcG9kcyBmYWxzZQoKLS0vLy0t"
}
