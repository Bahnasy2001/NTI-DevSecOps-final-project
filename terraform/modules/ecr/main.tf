resource "aws_ecr_repository" "ecr_repos" {
  for_each = toset(var.repo_names)
  force_delete = var.force_delete

  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}