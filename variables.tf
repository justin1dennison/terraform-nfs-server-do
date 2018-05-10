variable "region" {
  default = "nyc1"
}

variable "ssh_keyname" {
  default = "nfs-key"
}

variable "public_keypath" {}

variable "private_keypath" {}

variable "image" {
  default = "ubuntu-16-04-x64"
}

variable "name" {
  default = "nfs-server"
}

variable "size" {
  default = "1gb"
}

variable "dotoken" {
  description = "This is your API token for Digital Ocean"
}

variable "mount_point" {}
