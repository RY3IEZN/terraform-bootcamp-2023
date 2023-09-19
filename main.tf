
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

# create random string
resource "random_string" "bucket_name" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

# create output to see name
output "randomly_gen_name" {
  value = random_string.bucket_name.id
}
