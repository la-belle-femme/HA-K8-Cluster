provider "aws" {
  region = var.region
}

# Data source to dynamically fetch the Subnet IDs associated with the specified VPC and supported AZs
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0b29462da246e0151"]  # Your specified VPC ID
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]  # Only supported AZs
  }
}

resource "aws_instance" "loadbalancer" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name
  subnet_id     = element(data.aws_subnets.selected.ids, 0)  # Use first available subnet in supported AZs
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "k8s-loadbalancer"
  }
}

resource "aws_instance" "master" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t3.medium"
  key_name      = var.key_name
  subnet_id     = element(data.aws_subnets.selected.ids, count.index % length(data.aws_subnets.selected.ids))
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "k8s-master-${count.index + 1}"
  }
}

resource "aws_instance" "worker" {
  count         = 3
  ami           = var.ami_id
  instance_type = "t3.small"
  key_name      = var.key_name
  subnet_id     = element(data.aws_subnets.selected.ids, count.index % length(data.aws_subnets.selected.ids))
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  tags = {
    Name = "k8s-worker-${count.index + 1}"
  }
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s_sg"
  description = "Security group for Kubernetes cluster"
  vpc_id      = "vpc-0b29462da246e0151"  # Your specified VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "loadbalancer_ip" {
  value = aws_instance.loadbalancer.public_ip
}

output "master_ips" {
  value = aws_instance.master[*].public_ip
}

output "worker_ips" {
  value = aws_instance.worker[*].public_ip
}
