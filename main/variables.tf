/*
Define all variables that goes into main.tf. Modules variable.tf contains 
static values such as regions other variables that I am passing through main variables.tf.
*/
variable "var_credential" {
  default = "service_account_key.json"
}
variable "var_project" {
        default = "your-project-name"
    }
variable "var_env" {
  type = "map"

  default = {
    default = "default"
    dev = "dev"
    stg = "stg"
    prd = "prd"

  }
}

variable "uc1_private_subnet" {
    default = "10.26.1.0/24"
}
variable "uc1_public_subnet" {
        default = "10.26.2.0/24"
    }


