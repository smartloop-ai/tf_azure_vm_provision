variable "domain_name_label" {
  description = "DNS name label for the public IP"
  type        = string
  default     = "vm-dns-label"
}
variable "vpc_cidr_block" {
  description = "CIDR block for the virtual network"
}

variable "subscription_id" {
  description = "Subscription ID"
}

variable "resource_name" {
  description = "Name of the resource"
}

variable "location" {
  description = "Azure location for all resources"
  default     = "South Central US"
}

variable "vm_size" {
  description = "The size of the Azure Virtual Machine"
  default     = "Standard_NC40ads_H100_v5"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Admin password for the VM"
  default     = "P@ssw0rd!"
}

variable "admin_ssh_keys" {
  description = "List of admin SSH keys"
  type = list(object({
      username      = string
      public_key = string
  }))
}