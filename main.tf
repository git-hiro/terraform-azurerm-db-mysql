locals {
  sku_params     = "${split("_", var.mysql["sku_name"])}"
  sku_tier_short = "${element(local.sku_params, 0)}"
  sku_family     = "${element(local.sku_params, 1)}"
  sku_capacity   = "${element(local.sku_params, 2)}"

  sku_tier = "${
    local.sku_tier_short == "B" ? "Basic" : 
    local.sku_tier_short == "GP" ? "GeneralPurpose" : 
    local.sku_tier_short == "MO" ? "MemoryOptimized" : 
    ""}"
}

resource "azurerm_mysql_server" "mysql" {
  resource_group_name = "${var.mysql["resource_group_name"]}"

  name     = "${var.mysql["name"]}"
  location = "${var.mysql["location"]}"

  sku {
    name     = "${var.mysql["sku_name"]}"
    tier     = "${local.sku_tier}"
    family   = "${local.sku_family}"
    capacity = "${local.sku_capacity}"
  }

  storage_profile {
    storage_mb            = "${var.mysql["storage_gb"] * 1024}"
    backup_retention_days = "${var.mysql["backup_retention_days"]}"
    geo_redundant_backup  = "${var.mysql["geo_redundant_backup"]}"
  }

  administrator_login          = "${var.mysql["administrator"]}"
  administrator_login_password = "${var.mysql["administrator_password"]}"
  version                      = "${var.mysql["version"]}"
  ssl_enforcement              = "${var.mysql["ssl_enforcement"]}"
}

resource "azurerm_mysql_configuration" "configs" {
  count = "${length(keys(var.config))}"

  resource_group_name = "${azurerm_mysql_server.mysql.resource_group_name}"
  server_name         = "${azurerm_mysql_server.mysql.name}"

  name  = "${element(keys(var.config), count.index)}"
  value = "${lookup(var.config, element(keys(var.config), count.index))}"
}
