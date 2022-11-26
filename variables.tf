variable "region" {
  type = string
  description = "AWS region"
}

variable "environment" {
  type = string
  description = "The Environment - dev/stg/prod"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  default     = "oct-ec2-instance"
}

