resource "hcloud_server" "wpp-server" {
  count       = var.instances
  name        = "wpp-server-${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  labels = {
    type = "web"
  }
  user_data = file("wpp-server.yaml")
  ssh_keys = [ "rsa-key-20171111" ]
  firewall_ids = [ 1114609 ]

  provisioner "file" {
    source = "../../.env"
    destination = "/tmp/.env"
  }
}
