provider "digitalocean" {
  token = "${var.dotoken}"
}

data "template_file" "nfs-server-init" {
  template = "${file("templates/install_nfs_server.tpl")}"

  vars {
    mount_point = "${var.mount_point}"
  }
}

resource "digitalocean_ssh_key" "nfs-key" {
  name       = "${var.ssh_keyname}"
  public_key = "${file(var.public_keypath)}"
}

resource "digitalocean_droplet" "nfs-server" {
  image    = "${var.image}"
  name     = "${var.name}"
  region   = "${var.region}"
  size     = "${var.size}"
  ssh_keys = ["${digitalocean_ssh_key.nfs-key.id}"]

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file(var.private_keypath)}"
  }

  provisioner "file" {
    content     = "${data.template_file.nfs-server-init.rendered}"
    destination = "/tmp/install_nfs_server.sh"
  }

  provisioner "file" {
    source      = "scripts/base.sh"
    destination = "/tmp/base.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/*.sh",
      "/tmp/base.sh",
      "/tmp/install_nfs_server.sh",
    ]
  }
}
