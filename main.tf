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
  source        = "git::https://Aurolabs-feature-test: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@github.com/aurolab-it/terraform-aws-codepipeline-feature-intial.git?ref=feature/initial"
  pipeline_name = "deployment-pipeline"
  repo          = "Aurolabs-feature-test/aws-infrastructure-deployment-feature-intial"
  branch        = "feature-branch"
  connection    = data.aws_codestarconnections_connection.github.arn
}
