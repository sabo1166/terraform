resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  provider   = aws.dev
  tags = {
    "key" = "test"
    Name = "dev-vpc"
  }

}

resource "aws_s3_bucket" "name" {
  bucket   = "ertyucvghjdfgh"
  provider = aws.test

}