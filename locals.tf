locals {
  common_tags={
    Project=var.Project_name
    Env=var.Environment
    terraform=true
  }
  common_name_suffix = "${var.Project_name}-${var.Environment}" 
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}