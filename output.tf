output "mysql" {
  value = "${
    map(
      "name", "${azurerm_mysql_server.mysql.*.name}",
    )
  }"
}
