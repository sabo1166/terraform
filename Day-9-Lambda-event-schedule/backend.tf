terraform {
  backend "s3" {
    bucket       = "sabo1166-terraform-state-2026"
    key          = "terraform-statefile/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true ##supports terrafrom latest version >=1.10
    # dynamodb_table = "terraform-statefile-locking" ##supports terrafrom any version 

  }
}