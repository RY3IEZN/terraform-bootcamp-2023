terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "5.17.0"
    # }
  }
}

# provider "aws" {
#   region     = "if you send me the location"
#   access_key = "denied"
#   secret_key = "revoked lol"
# }

provider "terratowns" {
  endpoint  = "127.0.0.1:4567"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
