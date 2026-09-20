module "network" {
  source = "./modules/network"

  vpc_cidr = "10.0.0.0/16"
}

module "compute" {
  source = "./modules/compute"

  instance_type = "t3.micro"
  instance_name = "day-7-ec2"
}