output "public_Ip_of_Demo_server" {
    description = " This is public IP of DemoInstance"
    value = aws_instance.DemoInstance.public_ip
}
output "private_Ip_of_Demo_server" {
    description = " This is private IP of DemoInstance"
    value = aws_instance.DemoInstance.private_ip
}
