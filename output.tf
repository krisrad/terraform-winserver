output "win-server-ip" {
  value = [aws_instance.win-appserver.*.public_ip]
}
output "db-endpoint" {
  value = "${aws_db_instance.mssql.endpoint}"
}
output "db-instance" {
  value = "${aws_db_instance.mssql.identifier}"
}
