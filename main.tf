provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "automation:CreatedBy"         = "Terraform Cloud"
      "technical:TerraformWorkspace" = terraform.workspace
    }
  }

}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2*"]
  }
}

resource "aws_instance" "instance1" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
