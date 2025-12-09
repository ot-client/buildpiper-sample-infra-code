
variable "region" {
    type = string
    description = "Region"
  
}

variable "key_name" {
  type = string
  description = "Key name of the associated key"
}

variable "public_key" {
  type = string
  description = "The public key string"
}