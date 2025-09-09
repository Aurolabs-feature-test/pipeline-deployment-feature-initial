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
  source        = "git::https://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@github.com/Aurolabs-feature-test/terraform-aws-codepipeline-feature-initial.git?ref=feature-branch"
  pipeline_name = "deployment-pipeline"
  repo          = "Aurolabs-feature-test/aws-infrastructure-deployment-feature-initial"
  branch        = "feature-branch"
  connection    = data.aws_codestarconnections_connection.github.arn
}
