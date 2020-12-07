#Creating EC2 Instance
#Server Ubuntu Apache
resource "aws_instance" "Ubuntu-Apache" {
    ami = "ami-00ddb0e5626798373"
    instance_type = "t2.micro"
    key_name = "keypar-desafio1"
    associate_public_ip_address = "true"
    subnet_id = aws_subnet.sn-public-1.id
    tags = {
        Name = "Ubuntu-Apache"
    }
}