resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  depends_on = [aws_s3_bucket.name] #explicitily 
  tags = {
    Name = "test-depends_on"
  }

}
# resource "aws_subnet" "name" {
#   vpc_id     = aws_vpc.name.id
#   cidr_block = "10.0.1.0/24"

# }

# resource "aws_internet_gateway" "name" {
#   vpc_id = aws_vpc.name.id
# }

# resource "aws_route_table" "name" {
#   vpc_id = aws_vpc.name.id
# }

resource "aws_s3_bucket" "name" {
  bucket = "test-devtest-veera-2026-0922"
}