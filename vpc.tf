
#Creating VPC
resource "aws_vpc" "vpc-dati" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "vpc-Dati"
    }
}

#Creating Private Subnet 1
resource "aws_subnet" "sn-private-1" {
    vpc_id = aws_vpc.vpc-dati.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "sn-private-1"
    }
}

#Creating Private Subnet 2
resource "aws_subnet" "sn-private-2" {
    vpc_id = aws_vpc.vpc-dati.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "sn-private-2"
    }
}

#Creating Public Subnet 1
resource "aws_subnet" "sn-public-1" {
    vpc_id = aws_vpc.vpc-dati.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "sn-public-1"
    }
}

#Creating Public Subnet 2
resource "aws_subnet" "sn-public-2" {
    vpc_id = aws_vpc.vpc-dati.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "sn-public-2"
    }
}

#Creating Internet Gateway
resource "aws_internet_gateway" "igw-main" {
    vpc_id = aws_vpc.vpc-dati.id
    tags = {
        Name = "igw-main"
    }
}
#Creating Route Table
resource "aws_route_table" "main-route-table" {
    vpc_id = aws_vpc.vpc-dati.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-main.id
    }
    tags = {
        Name = "main"
    }
}

#Creating Route1
#resource "aws_route" "main-route-1" {
#    route_table_id = aws_route_table.main-route-table.id
#    destination_cidr_block = "10.0.0.0/16"
#}

#Creating Route2
#resource "aws_route" "main-route-2" {
#    route_table_id = aws_route_table.main-route-table.id
#    destination_cidr_block = "10.0.0.0/16"
#}

#Association route public
resource "aws_route_table_association" "main-pub-01" {
    subnet_id = aws_subnet.sn-public-1.id
    route_table_id = aws_route_table.main-route-table.id
}
#Association route public
resource "aws_route_table_association" "main-pub-02" {
    subnet_id = aws_subnet.sn-public-2.id
    route_table_id = aws_route_table.main-route-table.id
}

#Association route private
resource "aws_route_table_association" "main-priv-01" {
    subnet_id = aws_subnet.sn-private-1.id
    route_table_id = aws_route_table.main-route-table.id
}
#Association route private
resource "aws_route_table_association" "main-priv-02" {
    subnet_id = aws_subnet.sn-private-2.id
    route_table_id = aws_route_table.main-route-table.id
}

#Creating Security Group
resource "aws_security_group" "main-sg" {
    vpc_id      = aws_vpc.vpc-dati.id
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "desafio1"
    }
}
#Creating Endpoint
#resource "aws_vpc_endpoint" "s3" {
# vpc_id = aws_vpc.main.id
# service_name = "com.amazonaws.us-east-1.s3"
#}