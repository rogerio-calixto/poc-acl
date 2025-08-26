provider "aws" {
  region  = var.regiao
  profile = local.perfil

  default_tags {
    tags = {
      Project     = local.projeto
      Environment = var.ambiente
      CreatedBy   = local.criador
    }
  }
}