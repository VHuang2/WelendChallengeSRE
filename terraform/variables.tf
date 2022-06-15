variable "rg_name" {
  description = "Resource Group Name"
  type = string
}

variable "location" {
  description = "Location"
  type = string
}

variable "tags" {
  description = "tags"
  type = map(string)
}


variable "vpc_name" {
  description = "vpc name"
  type = string
}

variable "subnet_name" {
  description = "subname name"
  type = string
}

variable "vm_interface_name" {
  description = "interface name"
  type = string
}


variable "public_ip_name" {
  description = "public ip name"
  type = string
}

variable "vm_domain_name" {
  description = "vm domain name"
  type = string
}

variable "vm_name" {
  description = "vm name"
  type = string
}



