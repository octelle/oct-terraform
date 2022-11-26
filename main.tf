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
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  most_recent = true
}


module "example_instance" {
  source  = "app.terraform.io/octelle/module-ec2/tf"
  version = "~> 1.0.0"

  name          = var.instance_name
  instance_type = var.instance_type
  //subnet_id     = data.aws_subnets.private_subnets.ids[0]
  subnet_id     = "subnet-091ef76c2607e5010"
  ami           = data.aws_ami.al2.id

  user_data     = file("${path.module}/templates/user_data")
}

