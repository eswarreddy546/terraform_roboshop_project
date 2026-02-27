terraform {
  backend "s3" {
    bucket = "eshurr"
    key    = "remote-state-86-prod"
    region = "us-east-1"
  }
}