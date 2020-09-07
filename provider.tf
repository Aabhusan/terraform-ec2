provider "aws" {
    region    ="ap-southeast-2"
    version   ="~> 2.35"
  
}



terraform {
  required_version    = "~> 0.12.0"
  
  backend "remote" {
    organization  = "TestInc"
    workspaces {
      name        = "test-ec2-instance"
    }
  }
} 