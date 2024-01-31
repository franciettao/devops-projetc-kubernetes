# variables.tf
# variables.tf

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EC2 instance should be launched"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to the EC2 instance"
  type        = map(string)
  default     = {
      Name = "example-instance"
  }
}

variable "enable_public_ip" {
  description = "Whether to assign a public IP address to the EC2 instance"
  type        = bool
  default     = false
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the network interface, if applicable"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the EC2 instance"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "The user data to provide when launching the EC2 instance"
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Customize the root block device for the EC2 instance"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_devices" {
  description = "Customize additional EBS block devices for the EC2 instance"
  type        = list(map(string))
  default     = []
}

variable "monitoring" {
  description = "Enable/disable detailed monitoring for the EC2 instance"
  type        = bool
  default     = false
}

variable "tenancy" {
  description = "The tenancy of the EC2 instance (default: default)"
  type        = string
  default     = "default"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the EC2 instance (default: stop)"
  type        = string
  default     = "stop"
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags for EBS volumes attached to the instance (default: false)"
  type        = bool
  default     = false
}