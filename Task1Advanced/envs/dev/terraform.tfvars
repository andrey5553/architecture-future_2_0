# === Infrastructure variables ===
subnet_id      = "e9bnko718dlfitt039sq"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc6QMUaA78T4TVFZkXOH1HRXRc45Z6CXwmIHEB4Iv1nHeV+ZFOBvjoue0WgkkvlUOi2GhS1rpi/DWVTaHWMb5VMARBy/x5tgn7X9Ek86opk5w3L3kYHNbmTVTAV5wHYp1TPaLEnjK8HUxtUhLWeg/twzaQiZVKg5JFzbF7rAUNossRMJG13Vi39ja/gOoiLhlfAKE+XpbH9j9ATS+kAcdE4yVpM5lqdnvAzw85002ucE5rUm5zFW9IfL4iWkpMNNio4fVpilPYT1NOPq8gzbrnO3s8Imkh/emXsG+O0vuwyq0SdWPNcQ6tqwthwRxGHKeKw9DgkV8WXQl3Oxk5IHL5"

# === VM parameters ===
vm_name     = "dev-vm"
cores       = 2
memory      = 4
disk_size   = 20
disk_type   = "network-ssd"
environment = "dev"
zone        = "ru-central1-a"

# === Resource labels ===
labels = {
  env        = "dev"
  project    = "a1-task1"
  managed_by = "terraform"
}