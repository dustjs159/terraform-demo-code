# Declare the data source
data "aws_availability_zones" "azs" {}

module vpc {
  source = "./modules/vpc"
  #azs = data.aws_availability_zones.azs.names
}

module iam {
    source = "./modules/iam"
}