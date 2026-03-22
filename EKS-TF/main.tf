module "network" {
  source              = "./modules/network"
  vpc_name            = var.vpc-name
  igw_name            = var.igw-name
  subnet_name         = var.subnet-name
  subnet_name2        = var.subnet-name2
  rt_name2            = var.rt-name2
  security_group_name = var.security-group-name
}

module "iam" {
  source          = "./modules/iam"
  iam_role_eks    = var.iam-role-eks
  iam_role_node   = var.iam-role-node
}

module "eks" {
  source               = "./modules/eks"
  cluster_name         = var.cluster-name
  eksnode_group_name   = var.eksnode-group-name
  
  # Lấy output từ network module
  subnet_ids           = module.network.subnet_ids
  security_group_ids   = module.network.security_group_ids
  
  # Lấy output từ iam module
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  node_group_role_arn  = module.iam.node_group_role_arn

  # Đảm bảo IAM Policy được tạo xong thì EKS mới bắt đầu tạo để tránh lỗi
  depends_on = [module.iam]
}