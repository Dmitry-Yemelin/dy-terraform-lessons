Future Terraform Code :)

Do it yourself!

terraform {
  backend "s3" {
    bucket = "dmitry-yemelin-project-terraform-state"      // Bucket where to SAVE Terraform State
    key    = "prod/vpc/applications/app2/terraform.tfstate"    // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                      // Region where bycket created
  }
}
