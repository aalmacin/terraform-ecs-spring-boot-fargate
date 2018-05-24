terraform {
  backend "s3" {
    bucket = "spaced-repetition-state"
    key = "state/spacedRepetition.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
