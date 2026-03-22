module "network" {
  source      = "./modules/network"
  vpc_name    = var.vpc-name
  igw_name    = var.igw-name
  subnet_name = var.subnet-name
  rt_name     = var.rt-name
  sg_name     = var.sg-name
}

module "iam" {
  source   = "./modules/iam"
  iam_role = var.iam-role
}

module "compute" {
  source                = "./modules/compute"
  instance_name         = var.instance-name
  key_name              = var.key-name
  
  # Lấy dữ liệu (Outputs) từ module network và iam để truyền vào module compute
  subnet_id             = module.network.subnet_id
  security_group_id     = module.network.security_group_id
  instance_profile_name = module.iam.instance_profile_name
}