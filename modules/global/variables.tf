// for global variables that are not region specific
variable "env" {
  default = "dev"
}

variable "uc1_private_subnet" {
  default = "10.26.1.0/24"
}
variable "uc1_public_subnet" {
  default = "10.26.2.0/24"
}
