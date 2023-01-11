module "vpc" {

  source           = "./modules/vpc"
  application_name = local.app_name
  internet_route   = local.internet_route

}


module "ec2" {
  source           = "./modules/ec2"
  application_name = local.app_name
  subnet_id        = module.vpc.subnet_a_id
  vpc_id           = module.vpc.vpc_id

}
