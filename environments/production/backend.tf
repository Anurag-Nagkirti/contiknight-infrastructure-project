terraform {
  backend "s3" {
    bucket = "contiknight-terraform-state-bucket"
    key = "env/prod/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}
