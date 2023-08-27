variable "region" {
  description = "VPC Region"
  type        = string
  default     = "eu-west-1"
}
variable "vpc_cidr" {
  description = "VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}



variable "vpc_tag" {
  description = "Tag to change VPC name"
  type        = string
  default     = "Project-VPC"
}



variable "Prod_pub_sub_1_cidr" {
  description = "public subnet 1 cidr block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "Pub-1-tag" {
  description = "Tag to change public subnet 1 name"
  type        = string
  default     = "Prod-pub-sub1"
}

variable "Pub-2-tag" {
  description = "Tag to change public subnet 2 name"
  type        = string
  default     = "Prod-pub-sub2"
}

variable "Priv-1-tag" {
  description = "Tag to change private subnet 1 name"
  type        = string
  default     = "Priv-pub-sub1"
}

variable "Priv-2-tag" {
  description = "Tag to change private subnet2 name"
  type        = string
  default     = "Priv-pub-sub2"
}

variable "Prod_priv_sub_1_cidr" {
  description = "private subnet 1 cidr block"
  type        = string
  default     = "10.0.3.0/24"
}

variable "Prod_priv_sub_2_cidr" {
  description = "private subnet 2 cidr block"
  type        = string
  default     = "10.0.4.0/24"
}


variable "Prod_pub_sub_2_cidr" {
  description = "public subnet 2 cidr block"
  type        = string
  default     = "10.0.2.0/24"
}


variable "Prod-pub-route-table-cidr" {
  description = "public route table cidr block"
  type        = string
  default     = "10.0.3.0/24"
}



variable "Prod-priv-route-table-cidr" {
  description = "priv route table cidr block"
  type        = string
  default     = "10.0.4.0/24"
}

variable "Public-route-table-tag" {
  description = "Tag to change name of public route table"
  type        = string
  default     = "Prod-pub-route-table"
}


variable "Private-route-table-tag" {
  description = "Tag to change name of private route table"
  type        = string
  default     = "Prod-priv-route-table"
}


variable "igw" {
  description = " tag to change infrastructure name"
  type        = string
  default     = "Prod-igw"
}



variable "igw-cidr" {
  description = "destination cidr of igw"
  type        = string
  default     = "0.0.0.0/0"
}


variable "Nat-tag" {
  description = " tag to change infrastructure name"
  type        = string
  default     = "Prod-Nat-gateway"
}




variable "Nat-cidr" {
  description = " tag to change infrastructure name"
  type        = string
  default     = "0.0.0.0/0"
}





variable "AZ-1" {
  description = "availability zone for pub-sub"
  type        = string
  default     = "eu-west-1a"
}





variable "AZ-2" {
  description = "availability zone for pub-sub"
  type        = string
  default     = "eu-west-1b"
}



variable "AZ-3" {
  description = "availability zone for priv-sub"
  type        = string
  default     = "eu-west-1c"
}


variable "AZ-4" {
  description = "availability zone for priv-sub"
  type        = string
  default     = "eu-west-1b"
}


variable "tenancy" {
  description = "instance tenancy"
  type        = string
  default     = "default"
}

variable "dns-toggle" {
  description = "Should be true to enable"
  type        = bool
  default     = true
}