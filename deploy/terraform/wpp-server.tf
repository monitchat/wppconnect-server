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
}
