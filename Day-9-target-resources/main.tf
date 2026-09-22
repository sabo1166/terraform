provider "aws" {

}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "test-devtest-veera-2026-0922"
  }

}

resource "aws_s3_bucket" "name" {
  bucket = "test-devtest-2026-0922"

}

#terraform plan -target=aws_vpc.name to target resources instead of creation all resources 
# terraform apply -target=aws_vpc.name