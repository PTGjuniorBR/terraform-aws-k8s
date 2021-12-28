module "kubernetes" {
  source = "terraform/kubernetes/aws"

  aws_region    = "eu-west-1"
  cluster_name  = "treinamento-terraform-kubernetes"
  master_instance_type = "t3.small"
  worker_instance_type = "t3.small"
  ssh_public_key = "~/.ssh/id_rsa.pub"
  ssh_access_cidr = ["0.0.0.0/0"]
  api_access_cidr = ["0.0.0.0/0"]
  min_worker_count = 3
  max_worker_count = 6
  hosted_zone = "treinamentogjunior.k8s.teste.pt"
  hosted_zone_private = true

  master_subnet_id = "subnet-0215597ea7af5b8cd"
  worker_subnet_ids = [
      "subnet-051f67c026b7e2ccd",
      "subnet-0ee2499844d0ed952",
      "subnet-0215597ea7af5b8cd"
  ]

  # Tags
  tags = {
    Application = "AWS-Terraform-Kubernetes"
  }

  # Tags in a different format for Auto Scaling Group
  tags2 = [
    {
      key                 = "Application"
      value               = "AWS-Kubernetes"
      propagate_at_launch = true

    }
  ]

  addons = [
    "https://raw.githubusercontent.com/PTGjuniorBR/terraform-aws-k8s/master/addons/storage-class.yaml",
    "https://raw.githubusercontent.com/PTGjuniorBR/terraform-aws-k8s/master/addons/heapster.yaml",
    "https://raw.githubusercontent.com/PTGjuniorBR/terraform-aws-k8s/master/addons/dashboard.yaml",
    "https://raw.githubusercontent.com/PTGjuniorBR/terraform-aws-k8s/master/addons/external-dns.yaml",
    "https://raw.githubusercontent.com/PTGjuniorBR/terraform-aws-k8s/master/addons/autoscaler.yaml"
  ]
}