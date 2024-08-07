variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for the instances"
  type        = string
  default     = "ami-0a0e5d9c7acc336f1"
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instances"
  type        = string
}
