# Servidor-Publico

resource "aws_security_group" "sg-server01" {
  name        = "${local.projeto}-sg-server01-${var.ambiente}"
  description = "Habilita acesso ao tf server"
  vpc_id      = module.vpc-acl.aws_vpc_id
  
  ingress {
    description = "libera PING"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${local.vpc.cidr_block}"]
  }

  ingress {
    description = "libera SSH"
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

  tags = {
    Name        = "${local.projeto}-sg-server01-${var.ambiente}"
    Project     = local.projeto
    Environment = var.ambiente
  }
}

module "server01" {
  source              = "git::https://github.com/rogerio-calixto/aws-instance-template.git?ref=master"
  region              = var.regiao
  project             = local.projeto
  environment         = var.ambiente
  createdby           = local.criador
  ami                 = "ami-0427090fd1714168b"
  instance-type       = "t3.micro"
  keypair-name        = "keypair-pub-acl"
  vpc-id              = module.vpc-acl.aws_vpc_id
  subnet-id           = module.vpc-acl.public-subnet_ids[0]
  sg-id               = aws_security_group.sg-server01.id
  associate-public-ip = true
  instance-name       = "pub-acl-server-${var.ambiente}"
}

# Servidor-Privado

resource "aws_security_group" "sg-server02" {
  name        = "${local.projeto}-sg-server02-${var.ambiente}"
  description = "Habilita acesso ao server02"
  vpc_id      = module.vpc-acl.aws_vpc_id

  ingress {
    description = "libera SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "libera Portas Efemeras"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "libera PING"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${local.vpc.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.projeto}-sg-server02-${var.ambiente}"
    Project     = local.projeto
    Environment = var.ambiente
  }
}

module "server02" {
  source              = "git::https://github.com/rogerio-calixto/aws-instance-template.git?ref=master"
  region              = var.regiao
  project             = local.projeto
  environment         = var.ambiente
  createdby           = local.criador
  ami                 = "ami-0427090fd1714168b"
  instance-type       = "t3.micro"
  keypair-name        = "keypair-pvt-acl"
  vpc-id              = module.vpc-acl.aws_vpc_id
  subnet-id           = module.vpc-acl.private-subnet_ids[0]
  sg-id               = aws_security_group.sg-server02.id
  instance-name       = "pvt-acl-server-${var.ambiente}"
}