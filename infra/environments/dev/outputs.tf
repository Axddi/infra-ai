output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}