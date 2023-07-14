

# # Create Nat-Gateway

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.ingress.id
#   subnet_id     = element(module.vpc.public_subnets, 0)
#   depends_on    = [aws_internet_gateway.ig]

#   tags = {
#     Name = "K8s-nat-gateway"
#   }
# }
