/*
 For capturing and saving tfstate on Google Storage bucket or other cloud storage, that can be shared with other developers.
*/
terraform {
  backend "gcs" { // in gcp
    bucket  = "terraform-state-bucket"
    prefix  = "dev"
     credentials = "./service_account_key.json"
  }
}