output "appserver-ip" {
  value = [aws_instance.win-appserver.*.public_ip]
}
