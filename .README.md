# terraform-google-compute-engine

## Installing Terraform

### For Linux users:
1. Install unzip
`sudo apt-get install unzip`

2. Confirm the latest version number on the terraform website:
`https://www.terraform.io/downloads.html`

3. Download latest version of the terraform (substituting newer version number if needed)
`wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip`

4. Extract the downloaded file archive
`unzip terraform_0.12.18_linux_amd64.zip`

5. Move the executable into a directory searched for executable
`sudo mv terraform /usr/local/bin/`

6. Make sure Terraform works
`terraform --version`