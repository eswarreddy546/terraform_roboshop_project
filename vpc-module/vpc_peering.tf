resource "aws_vpc_peering_connection" "peeringg" {
    # count= 0 # failes 1 means true

  count = var.peering_is_required ? 1 : 0

  peer_vpc_id   = data.aws_vpc.default.id
  vpc_id        = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept = true
}


resource "aws_route" "a_to_b_public" {
  count                     = var.peering_is_required ? 1 : 0
  route_table_id            = aws_route_table.publicrt.id
  destination_cidr_block    = data.aws_vpc.default.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peeringg[0].id
}

resource "aws_route" "b_to_apublic" {
  count                     = var.peering_is_required ? 1 : 0
  route_table_id            = aws_route_table.publicrt.id
  destination_cidr_block    = var.mycidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peeringg[0].id
}