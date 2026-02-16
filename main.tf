terraform {
  backend "s3" {
    bucket = "contiknight-terraform-state-bucket"
    key = "env/prod/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}


###
### Modules ###
###

module "vpc" {
    source = "./modules/vpc_module"
    cidr_block = var.vpc_cidr
}


module "ec2" {
    source = "./modules/ec2_module"
}
