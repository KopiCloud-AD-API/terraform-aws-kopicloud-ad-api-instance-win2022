# Application Definition 
app_environment = "dev"  # Dev, Test, Staging, Prod, etc

# Network
vpc_cidr           = "10.11.0.0/16"
public_subnet_cidr = "10.11.1.0/24"

# AWS Settings
aws_access_key = "update-this"
aws_secret_key = "update-this"
aws_region     = "eu-west-1"

# Windows Virtual Machine
api_instance_name               = "kopiadapi01"
api_instance_type               = "t3.medium"
api_associate_public_ip_address = true
api_root_volume_size            = 30
api_root_volume_type            = "gp2"
