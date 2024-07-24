variable "resource_group_location" {
  type        = string
  description = "The location of the resource group"
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
  default     = "student-rg"
}

variable "username" {
  type        = string
  description = "The username for the VM"
  default     = "azureuser"
}

variable "vm_admin_password" {
  type        = string
  description = "VM User password"
  default     = "uCHANGEME!"
}

variable "vnet" {
  type        = string
  description = "The name of the virtual network"
  default     = "student-vnet"
}

variable "subnet" {
  type        = string
  description = "The name of the subnet"
  default     = "student-subnet"
}

variable "nsg" {
  type        = string
  description = "Name of the network security group"
  default     = "student-nsg"
}

variable "public_ip" {
  type        = string
  description = "Name of the VM Public IP"
  default     = "student-pip"
}

variable "nic" {
  type        = string
  description = "Name of the VM Network Interface"
  default     = "student-nic"
}

variable "vm_name" {
  type        = string
  description = "Name of the Virtual Machine"
  default     = "student-vm"
}

variable "rg_backend" {
  type    = string
  default = "rg-tfbackend"
}

variable "storage_account" {
  type    = string
  default = "tfbackendsaccount"
}

variable "container_name" {
  type    = string
  default = "tfstate"
}