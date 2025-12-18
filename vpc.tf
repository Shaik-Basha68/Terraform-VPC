resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.tenancy
  enable_dns_hostnames = true
    tags = merge(
            local.common_tags,
            var.tags,{
                Name=local.common_name_suffix
                } 
            )

    
}

resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main.id
    tags = merge(
            local.common_tags,
            var.igw_tags,{
                Name="${local.common_name_suffix}-igw"
                } 
            )
  
}

resource "aws_subnet" "publc_subnet" {
    vpc_id = aws_vpc.main.id
    count = length(var.public_subnet_cidrs)
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    map_public_ip_on_launch = true
    tags = merge(
            local.common_tags,
            var.subnet_tags,{
                Name="${local.common_name_suffix}-public-subnet-${local.azs[count.index]}"
                } 
            ) 
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main.id
    count = length(var.private_subnet_cidrs)
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    map_public_ip_on_launch = false
    tags = merge(
            local.common_tags,
            var.subnet_tags,{
                Name="${local.common_name_suffix}-private-subnet-${local.azs[count.index]}"
                } 
            ) 
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    tags = merge(
            local.common_tags,
            var.public_rt_tags,{
                Name="${local.common_name_suffix}-public-rt"
                } 
            ) 
}
resource "aws_route" "public_rt_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id
    tags = merge(
            local.common_tags,
            var.private_rt_tags,{
                Name="${local.common_name_suffix}-private-rt"
                } 
            ) 
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = merge(
            local.common_tags,
            var.eip_tags,{
                Name="${local.common_name_suffix}-nat-eip"
                } 
            )
  
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.publc_subnet[0].id

  tags = merge(
            local.common_tags,
            var.nat_gateway_tags,{
                Name="${local.common_name_suffix}-nat-gw"
                } 
            )
    depends_on = [ aws_internet_gateway.main_igw ]

}

resource "aws_route" "private_rt_route" {
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
}


resource "aws_route_table_association" "public_rt_assoc" {
    count = length(aws_subnet.publc_subnet)
    subnet_id = aws_subnet.publc_subnet[count.index].id
    route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "private_rt_assoc" {
    count = length(aws_subnet.private_subnet)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_rt.id
}
