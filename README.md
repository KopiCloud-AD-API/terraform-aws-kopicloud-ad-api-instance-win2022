# Deploy an AWS EC2 Instance with KopiCloud AD API in Windows Server 2022
[![Terraform](https://img.shields.io/badge/terraform-v1.3+-blue.svg)](https://www.terraform.io/downloads.html)
[![KopiCloud-AD](https://img.shields.io/badge/kopiCloud_ad-v1.0+-blueviolet.svg)](https://www.kopicloud-ad-api.com)

The Terraform code in this repo will deploy an EC2 Instance for **KopiCloud AD API** with Windows Server 2022 and SQL Server 2022 Express.

## Network Configuration

- The code will create a network (VPC and Subnet); if you want to deploy to existing VPC and Subnet, edit the **api-vm-main.tf** file.

in the **aws_security_group** section, comment the vpc_id = aws_vpc.vpc.id line and add the existing vpc id reference, following the example below:

```
resource "aws_security_group" "api-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-sg"
  description = "Allow incoming connections"
  //vpc_id      = aws_vpc.vpc.id
  vpc_id      = "vpc-07bc47fcb892f49c2"
```

and then in **aws_instance** section, comment the subnet_id = aws_subnet.public-subnet.id line and add the existing subnet id reference, following the example below:

```
resource "aws_instance" "api-server" {
  ami           = data.aws_ami.windows-2022.id
  instance_type = var.api_instance_type
  //subnet_id     = aws_subnet.public-subnet.id
  subnet_id     = "subnet-0de7e64c5c78e47f4"
```

## Public IP

By default, the code adds a public IP address to the EC2 instance.

If you don't want to publish the API using an external IP, remove the **resource "aws_eip"** and **resource "aws_eip_association"** sections.

And set the variable **api_associate_public_ip_address** to false.

## Notes

- By default, the download and installation of **SQL Server Management Studio** is disabled because it will take lots of time.

- The default Windows username is **Administrator**, and get the password from the AWS Console.

## How to Set Up KopiCloud AD API

1. Get a License - Generate a free trial license (no credit card required) or purchase a license [here](https://www.kopicloud-ad-api.com/get-license)

2. Install **KopiCloud AD API** using the code in this repo

3. Join the machine to the AD Domain to manage using the API

4. Run the **KopiCloud AD API Config tool** located in the folder **C:\KopiCloud-AD-API-Config**
