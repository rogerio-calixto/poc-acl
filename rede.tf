module "vpc-acl" {
  source                     = "git::ssh://calixtofutura@bitbucket.org/futura_plataforma/terraformfuturatemplatenetwork.git"
  vpc_name                   = local.vpc.name
  subnet_name                = local.vpc.subnet_name
  route_table_name           = local.vpc.routetable_name
  internet_gateway_name      = local.vpc.internet_gateway_name
  aws_region                 = var.regiao
  project                    = local.projeto
  environment                = var.ambiente
  createdby                  = local.criador
  cidr_block                 = local.vpc.cidr_block
  subnet_pvt_config          = local.vpc.subnet_pvt_config
  subnet_pub_config          = local.vpc.subnet_pub_config
  subnet_pub_transit_gateway = []
}