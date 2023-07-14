

output "cluster_name" {
  description = "Name of EKS cluster in AWS."
  value       = module.eks.cluster_name
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "ecr_app_url" {
  description = "ECR repo name for app"
  value       = aws_ecr_repository.app.repository_url
}

output "efs_csi_sa_role" {
  value = module.efs_csi_irsa_role.iam_role_arn
}

output "efs_id" {
  value = aws_efs_file_system.data.id
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.db.db_instance_address
}

# output "subnet_az_mapping" {
#   value = {
#     for subnet in module.vpc.private_subnets : subnet.id => subnet.availability_zone
#   }
# }