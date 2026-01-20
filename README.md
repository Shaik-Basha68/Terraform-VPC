#Terraform AWS VPC

This module creates the following resources.
* VPC
* IGW
* 2 Public subnets in ap-south-1a and ap-south-1b AZ
* 2 Private subnets in ap-south-1a and ap-south-1b AZ
* Public Route table
* Private Route table
* EIP for NAT
* NAT Gateway in public subnet 1a az
* IGW route is added to public route table
* NAT gateway route to private routetables
* Route tabe association with subbnets
* VPC to default VPC peering
* Public route table to default VPC route
* Default VPC main route table to create VPC route

###Inputs

* vpc_cidr -> (Required). User must supply the CIDR for VPC
* project_name  -> (Required). User must supply the project name.
* environment -> (Required). User must supply the environment name.
