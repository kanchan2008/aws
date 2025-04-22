module "vpc" {
  source = "../../modules/vpc"

  name = "dev"
  cidr = "10.0.0.0/16"
  azs  = ["us-west-2a", "us-west-2b"]
}

module "eks" {
  source            = "../../modules/eks"
  name              = "dev"
  subnet_ids        = module.vpc.private_subnet_ids
  public_subnets    = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  cluster_role_arn  = module.vpc.eks_role_arn
  region            = var.region
}

module "ecr" {
  source = "../../modules/ecr"
  name   = "my-app-repo"
}

output "ecr_url" {
  value = module.ecr.repository_url
}
