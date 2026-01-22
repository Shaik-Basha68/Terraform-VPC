output "vpc_id" {
     description = "The ID of the VPC"
     value       = aws_vpc.main.id
 }


 output "azs" {
   value = data.aws_availability_zones.available
 }

output "default_vpc_id" {
    description = "The ID of the default VPC"
    value       = data.aws_vpc.selected

}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

