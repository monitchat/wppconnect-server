output "web_servers_status" {
  value = {
    for server in hcloud_server.wppconnect-server :
    server.name => server.status
  }
}

output "web_servers_ips" {
  value = {
    for server in hcloud_server.wppconnect-server :
    server.name => server.ipv4_address
  }
}
