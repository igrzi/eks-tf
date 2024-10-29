output "service_account_name" {
  description = "The name of the EKS service account"
  value       = kubernetes_service_account.this.metadata.0.name
}