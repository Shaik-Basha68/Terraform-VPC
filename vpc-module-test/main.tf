module "vpc" {
  source       = "../"
  vpc_cidr     = var.vpc_cidr
  tenancy      = var.tenancy
  tags         = var.tags
  Project_name = var.Project_name
  Environment  = var.Environment
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  is_peering_required= true
  
}


