provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "automation:CreatedBy"         = "Terraform Cloud"
      "technical:TerraformWorkspace" = terraform.workspace
    }
  }
}

data "aws_ami" "al2" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2*"]
  }

  most_recent = true
}


module "example_instance" {
  source  = "app.terraform.io/octelle/module-ec2/tf"
  version = "~> 1.0.1"

  name          = var.instance_name
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.private_subnets.ids[0]
  ami           = data.aws_ami.al2.id

  user_data     = file("${path.module}/templates/user_data")
}

