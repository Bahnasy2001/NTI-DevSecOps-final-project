terraform {
  backend "s3" {
    bucket = "terraform-state-bahnasy"
    key = "${var.environment}/terraform.tfstate"
    region = var.region
    use_lockfile = true
  }
}