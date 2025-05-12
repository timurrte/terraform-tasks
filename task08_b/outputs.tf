output "redis_fqdn" {
  description = "Redis FQDN"
  value       = module.aci_redis.redis_fqdn
}

output "aca_fqdn" {
  value       = module.aca.aca_fqdn
  description = "FQDN of App in Azure Container App"
}
output "aks_lb_ip" {
  value       = module.k8s.aks_lb_ip
  description = "Load Balancer IP address of APP in AKS"
}

output "aks_config" {
  value       = module.aks.config
  description = "AKS config"
  sensitive   = true
}
