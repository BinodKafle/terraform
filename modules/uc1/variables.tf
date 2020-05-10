variable "env" {
 type = "string"
}

variable "var_region_name" {
  default = "us-central1"
}

variable "var_uc1_public_subnet" {
  type = "string"
}
variable "var_network_self_link" {
  type = "string"
}

variable "region_map" {
  type = "map"
  default = {
    us-central1 = "us-central1"
  }
}

variable "var_uc1_private_subnet" {
  type = "string"
}



