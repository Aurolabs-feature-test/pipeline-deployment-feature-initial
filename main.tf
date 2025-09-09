terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Reference existing GitHub connection
data "aws_codestarconnections_connection" "github" {
  name = "Terraform-Github"
}

# Pipeline module
module "pipeline" {
  source        = "git@github.com:Aurolabs-feature-test/terraform-aws-codepipeline-feature-intial.git?ref=feature-branch"
  pipeline_name = "deployment-pipeline"
  repo          = "Aurolabs-feature-test/aws-infrastructure-deployment-feature-intial"
  branch        = "feature-branch"
  connection    = data.aws_codestarconnections_connection.github.arn
}
