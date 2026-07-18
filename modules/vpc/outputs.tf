output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_arn" {
  value = aws_vpc.this.arn
}

output "cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnet)[*].id
}

output "public_cidrs" {
  value = values(aws_subnet.public_subnet)[*].cidr_block
}

output "private_cidrs" {
  value = values(aws_subnet.private_subnet)[*].cidr_block
}