output "vpc_id"            { value = aws_vpc.this.id }
output "frontend_subnet_id" { value = aws_subnet.public_frontend.id }
output "backend_subnet_id"  { value = aws_subnet.public_backend.id }
output "rds_subnet_id"      { value = aws_subnet.private_rds.id }