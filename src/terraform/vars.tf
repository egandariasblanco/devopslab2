variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "nombre" {
  type = string
  description = "Prefijo de nombre para todos los recursos creados"
  default = "kubendika"
}

variable "lab2" {
  description = "Map de las configuraciones."
  type        = map
  default     = {
    master = {
      privip = "10.0.1.10"
      size = "Standard_A2_v2"
    },
    worker1 = {
      privip = "10.0.1.11"
      "size" = "Standard_A1_v2"
    },
    worker2 = {
      privip = "10.0.1.12"
      size = "Standard_A1_v2"
    }
  }
}