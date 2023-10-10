provider "google" {
  credentials = "${file("credential.json")}"
  project     = "noble-hydra-398406"
  region      = "asia-south1"
  zone        = "asia-south1-b"
}