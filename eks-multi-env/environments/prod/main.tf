module "vpc" {
  source = "../../modules/vpc"

  name = "prod"
  cidr = "10.1.0.0/16"
  azs  = ["us-west-2a", "us-west-2b"]
}

module "eks" {
  source            = "../../modules/eks"
  name              = "prod"
  subnet_ids        = module.vpc.private_subnet_ids
  public_subnets    = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  cluster_role_arn  = module.vpc.eks_role_arn
  region            = var.region
}

module "ecr" {
  source = "../../modules/ecr"
  name   = "prod-app-repo"
}

module "rds" {
  source = "../../modules/rds"
  name   = "prod-db"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  db_username = var.db_username
  db_password = var.db_password
  eks_node_sg = module.eks.eks_node_sg_id
}

module "alb_ingress" {
  source = "../../modules/alb-ingress"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  cluster_name = module.eks.cluster_name
}

output "ecr_url" {
  value = module.ecr.repository_url
}

output "rds_endpoint" {
  value = module.rds.endpoint
}