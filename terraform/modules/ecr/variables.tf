variable "repo_names" {
  description = "List of repository names to create"
  type        = list(string)
}

variable "scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  description = "Image tag mutability: MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "force_delete" {
  description = "Whether to force delete ECR repositories"
  type        = bool
  default     = false
}