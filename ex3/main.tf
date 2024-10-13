resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name        = "mlelievre_instance"
  provider    = openstack.ovh
  image_name  = "Ubuntu 22.04"
  flavor_name = "d2-4"
  user_data = <<-EOF
    #! /bin/bash
    sudo apt update
    sudo apt install nginx
    sudo systemctl start nginx
  EOF
  
  network {
  name = "Ext-Net"
  }

  lifecycle {
    ignore_changes = [
      image_name
    ]
  }
}

resource "openstack_networking_floatingip_v2" "floating_ip" {
    pool     = "Ext-Net"
}

