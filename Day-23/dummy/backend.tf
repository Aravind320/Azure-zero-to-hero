terraform {
  backend "azurerm" {
    storage_account_name = "azurebackendstoragearvi"
    container_name = "backend"
    key = "terraform.tfstate"
    access_key = ""
  }
}