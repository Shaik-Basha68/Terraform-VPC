 output "vpc_id" {
   description = "The ID of the VPC"
   value       = module.vpc.vpc_id
 }

 output "azs" {
   description = "List of availability zones"
   value       = data.aws_availability_zones.available.names

 }

 output "default_vpc_id" {
   description = "The ID of the default VPC"
   value       = data.aws_vpc.selected

 }
