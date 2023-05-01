########################################
## Virtual Machine Module - Variables ##
########################################

variable "api_instance_type" {
  type        = string
  description = "EC2 instance type for API Server"
  default     = "t3.medium"
}

variable "api_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the API Instance"
  default     = true
}

variable "api_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of API Instance"
  default     = "30"
}

variable "api_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of the API Instance. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "api_instance_name" {
  type        = string
  description = "EC2 instance name for the API Instance"
  default     = "kopiadapi01"
}