# Local state is used on first run so Terraform can create the state bucket
# itself. Once the bucket below exists, uncomment this block, fill in the
# bucket name, then run `terraform init -migrate-state` to move state into S3.
#
# terraform {
#   backend "s3" {
#     bucket = "<your-terraform-state-bucket-name>"
#     key    = "pravinmishradmi-site/terraform.tfstate"
#     region = "eu-north-1"
#   }
# }
