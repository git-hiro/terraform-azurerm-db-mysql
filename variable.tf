variable "mysql" {
  default = {
    resource_group_name = ""

    name     = ""
    location = "japaneast"

    sku_name   = ""
    storage_gb = 512

    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"

    administrator          = ""
    administrator_password = ""

    version         = "5.7"
    ssl_enforcement = "Enabled"
  }
}

variable "config" {
  default = {}
}
