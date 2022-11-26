data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
}
