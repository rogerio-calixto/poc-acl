locals {
  perfil  = "tf-user"
  projeto = "acl"
  criador = "Terraform"

  vpc = {
    name                  = "vpc"
    subnet_name           = "subnet"
    routetable_name       = "rt"
    internet_gateway_name = "igw"
    cidr_block            = "9.0.0.0/24"
    subnet_pvt_config = [{
      cidr_block              = "9.0.0.0/27"
      available_zone          = "us-east-1a"
      map_public_ip_on_launch = false
      },
      {
        cidr_block              = "9.0.0.32/27"
        available_zone          = "us-east-1b"
        map_public_ip_on_launch = false
    }]
    subnet_pub_config = [{
      cidr_block              = "9.0.0.64/27"
      available_zone          = "us-east-1a"
      map_public_ip_on_launch = true
      },
      {
        cidr_block              = "9.0.0.96/27"
        available_zone          = "us-east-1b"
        map_public_ip_on_launch = true
    }]
  }
}