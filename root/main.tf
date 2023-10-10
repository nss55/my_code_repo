resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "asia-south1-b"
  size  = 10
  
 }
 resource "google_compute_attached_disk" "default2" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.for_bashscript.id
}
resource "google_compute_instance" "for_bashscript" {
  name         = "my-bashshell"
  machine_type = "e2-small"
  zone         = "asia-south1-b"
  can_ip_forward = false
  
  boot_disk {
    initialize_params {
    image = "debian-11-bullseye-v20231004"
    /*labels = {
    my_label = "value"
      }*/
    }
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }
    network_interface {
    network = "default"
    access_config {}
}
metadata_startup_script = file("/home/nitesh/test.sh")
 
  /*# Copy in the bash script we want to execute.
provisioner "file" {
    source = "test.sh"
    destination = "/test.sh"
     connection {
        type = "ssh"
        
   }
}
    provisioner "remote-exec" {
    inline = [
      "chmod +x /test.sh",
      "./test.sh"
    ]
    connection {
        type = "ssh"
      host = "bashshell"  
    }
 }*/
}




 


 