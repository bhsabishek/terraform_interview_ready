terraform {
  backend "s3" {
    bucket       = "s3-managed-terraform-tffile"
    key          = "terraform.tfstate"  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = true 
  }
}