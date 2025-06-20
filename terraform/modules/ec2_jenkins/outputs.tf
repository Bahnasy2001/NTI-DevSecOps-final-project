output "jenkins_public_ip" {
  description = "Public IP of Jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_id" {
  description = "Instance ID"
  value       = aws_instance.jenkins.id
}

output "jenkins_sg_id" {
  description = "Security Group ID for Jenkins EC2"
  value       = aws_security_group.jenkins_sg.id
}
output "instance_profile_name" {
  description = "Name of IAM instance profile to attach to EC2"
  value       = aws_iam_instance_profile.jenkins_instance_profile.name
}
