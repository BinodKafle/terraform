/*
 Execute terraform from here. It contains following sections:

1. Provider section: defines Google as provider
2. Module section: GCP resource that points to each modules in module folder
3. Output section: displaying outputs after Terraform apply 
*/

provider "google" {
  project    ="${var.var_project}"
  credentials = "${file(var.var_credential)}"
}

module "vpc" {
source = "../modules/global" 
  env                   = "${var.var_env}"
}
module "uc1" {
  source                = "../modules/uc1"
  var_network_self_link     = "${module.vpc.out_vpc_self_link}"
  var_uc1_public_subnet = "${var.uc1_public_subnet}"
  var_uc1_private_subnet= "${var.uc1_private_subnet}"
  env                   = "${var.var_env}"
}

######################################################################
# Display Output Public Instance
######################################################################
output "uc1_public_address"  { value = "${module.uc1.uc1_pub_address}"}
output "uc1_private_address" { value = "${module.uc1.uc1_pri_address}"}
output "vpc_self_link" { value = "${module.vpc.out_vpc_self_link}"}
