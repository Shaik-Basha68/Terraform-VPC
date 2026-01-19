resource "aws_vpc_peering_connection" "peering" {
    count= var.is_peering_required ? 1: 0
    vpc_id        = aws_vpc.main.id
    peer_vpc_id   = data.aws_vpc.selected.id
    #peer_region   = var.peer_region
    auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags = merge(
        local.common_tags,
        var.tags,{
            Name="${local.common_name_suffix}-peering"
            } 
        )
}

resource "aws_route" "public_peering_route" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = data.aws_vpc.selected.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
  
}
resource "aws_route" "default" {
     count = var.is_peering_required ? 1 : 0
    route_table_id = data.aws_route_table.main.id
    destination_cidr_block = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}
