resource "openstack_networking_floatingip_v2" "floating_ip" {
    pool     = "Ext-Net"
    region   = "GRA7"
}

resource "openstack_compute_floatingip_associate_v2" "instance_floating" {
  floating_ip = "${openstack_networking_floatingip_v2.floating_ip4.address}"
  instance_id = "${openstack_compute_instance_v2.test_terraform_instance.id}"
  region = "GRA7"
}


resource "openstack_compute_keypair_v2" "test-keypair" {
  name   = "my-keypair"
  region = "GRA7"
}



resource "openstack_compute_instance_v2" "test_terraform_instance" {
  name        = "mlelievre_instance"
  provider    = openstack.ovh
  image_name  = "Ubuntu 22.04"
  flavor_name = "d2-4"
  key_pair    = "my-keypair"
  region      = "GRA7"

  
  network {
  name = "Ext-Net"
  }

  lifecycle {
    ignore_changes = [
      image_name
    ]
  }

  user_data = <<-EOF
    #! /bin/bash
    sudo apt update
    sudo apt install nginx
    sudo systemctl start nginx
  EOF
}


