
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "linux_virtual_machine_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "linux_virtual_machine_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}
