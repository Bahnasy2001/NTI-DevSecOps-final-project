variable "instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "AMI ID to use for Jenkins EC2"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "subnet_id" {
  description = "The public subnet to launch Jenkins EC2"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to associate security group"
  type        = string
}

variable "security_group_ids" {
  description = "List of security groups to associate"
  type        = list(string)
  default     = []
}


variable "associate_public_ip_address" {
  description = "Whether to associate public IP to EC2"
  type        = bool
  default     = true
}

variable "jenkins_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "jenkins-server"
}

variable "tags" {
  description = "Additional tags to apply"
  type        = map(string)
  default     = {}
}

variable "root_volume_size" {
  description = "Size of root EBS volume in GB"
  type        = number
  default     = 30
}

variable "enable_ecr_access" {
  description = "Enable ECR full access"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_access" {
  description = "Enable CloudWatch agent permissions"
  type        = bool
  default     = true
}

variable "enable_backup_access" {
  description = "Enable AWS Backup permissions"
  type        = bool
  default     = true
}


variable "allowed_ip_for_jenkins" {
  description = "IP allowed to access Jenkins UI (e.g. 102.43.176.23/32)"
  type        = string
}
