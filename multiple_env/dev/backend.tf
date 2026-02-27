terraform {
  backend "s3" {
    bucket = "eshurr"
    key    = "remote-state-86-dev"
    region = "us-east-1"
  }
}