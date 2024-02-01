resource "hcloud_server" "wppconnect-server" {
  count       = var.instances
  name        = "wppconnect-server-${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  labels = {
    type = "web"
  }
  user_data    = file("wpp-server.yaml")
  ssh_keys     = ["rsa-key-20171111"]
  firewall_ids = [1114609]

  provisioner "file" {
    source      = "${path.root}/../../.env.prod"
    destination = "/tmp/.env"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/home/ricardoperovano/keys/windows_openssh")
      host        = self.ipv4_address
    }

  }
}
