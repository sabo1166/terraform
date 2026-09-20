

# ========================================
# VPC
# ========================================

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "day1-vpc"
  }
}


# ========================================
# Internet Gateway
# ========================================

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "day1-igw"
  }
}


# ========================================
# Public Subnet
# ========================================

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "day1-public-subnet"
  }
}


# ========================================
# Public Route Table
# ========================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "day1-public-route-table"
  }
}


# ========================================
# Route Table Association
# ========================================

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# ========================================
# Latest Amazon Linux 2023 AMI
# ========================================

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# ========================================
# Existing IAM Role
# ========================================

data "aws_iam_role" "iam_1" {
  name = "iam-1"
}


# ========================================
# IAM Instance Profile
# ========================================

resource "aws_iam_instance_profile" "iam_1" {
  name = "day1-iam-profile"
  role = data.aws_iam_role.iam_1.name
}


# ========================================
# EC2 Instance
# ========================================

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  iam_instance_profile = aws_iam_instance_profile.iam_1.name

  tags = {
    Name = "day1-ec2"
  }
}