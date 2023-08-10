variable "region" {
    default = "ap-south-1a"
}
variable "os-name" {
    default = "ami-0f5ee92e2d63afc18"
}
variable "key" {
    default = "Demo-Keypair"
}
variable "instance-type" {
    default = "t2.micro"
}
variable "vpc-cidr" {
    default = "10.10.0.0/16"
}
variable "subnet-cidr" {
    default = "10.10.1.0/24"
}
variable "subnet-az" {
    default = "ap-south-1a"
}
