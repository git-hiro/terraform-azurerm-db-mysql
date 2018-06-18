output "mysql" {
  value = "${
    map(
      "name", "${azurerm_mysql_server.mysql.name}",
      "fqdn", "${azurerm_mysql_server.mysql.fqdn}",
    )
  }"
}
