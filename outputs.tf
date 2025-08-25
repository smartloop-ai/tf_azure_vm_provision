output "vm_public_ip" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "admin_user" {
  description = "Admin user on the VM"
  value       = "azureadmin"
}

output "dns_name" {
  description = "The DNS name of the public IP"
  value       = azurerm_public_ip.main.fqdn
}