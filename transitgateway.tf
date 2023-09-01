# Criação do Transit Gateway
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description = "Transit Gateway Terraform"
}

# Criação da associação da VPC 1 ao Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1_attachment" {
  transit_gateway_id  = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id              = aws_vpc.az_vpc.id
  subnet_ids          = [aws_subnet.private_subnet.id]
}

# Criação da associação da VPC 2 ao Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2_attachment" {
  transit_gateway_id  = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id              = aws_vpc.bastion_vpc.id
  subnet_ids          = [aws_subnet.public_subnet_bastion.id]
}
