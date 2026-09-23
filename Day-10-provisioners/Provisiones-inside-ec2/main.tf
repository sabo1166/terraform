
# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# VPC
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

# Subnet
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

# Route Table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Route Table
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

# Security Group
resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Ubuntu)
resource "aws_instance" "server" {
  ami                         = "ami-0261755bbcb8c4a84" # Ubuntu AMI
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.example.key_name
  subnet_id                   = aws_subnet.sub1.id
  vpc_security_group_ids      = [aws_security_group.webSg.id]
  associate_public_ip_address = true

  tags = {
    Name = "UbuntuServer"
  }

   # ## SSH connection configuration
  connection {

    type = "ssh" # ## Use SSH protocol to connect to EC2

    user = "ubuntu" # ## Ubuntu default SSH username

    private_key = file("~/.ssh/id_ed25519") # ## Read SSH private key from local machine

    host = self.public_ip # ## Connect using this EC2 Public IP

    timeout = "2m" # ## Wait up to 2 minutes for SSH connection
  }


  # ## FILE PROVISIONER
  # ## Copy a file from local machine to EC2
  provisioner "file" {

    source = "file10" # ## Local file that Terraform will upload

    destination = "/home/ubuntu/file10" # ## Destination path inside EC2
  }


  # ## REMOTE-EXEC PROVISIONER
  # ## Execute commands inside the EC2
  provisioner "remote-exec" {

    inline = [

      "touch /home/ubuntu/file200", # ## Create file200 inside EC2

      "echo 'hello from veera nareshit hyd FDE' >> /home/ubuntu/file200" # ## Add text to file200
    ]
  }


  # ## LOCAL-EXEC PROVISIONER
  # ## Execute command on the local machine
  provisioner "local-exec" {

    command = "touch file500" # ## Create file500 on your local computer

  }
}




#Solution-2 to Re-Run the Provisioner
#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server
# terraform apply