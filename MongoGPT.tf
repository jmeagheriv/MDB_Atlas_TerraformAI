resource "mongodbatlas_cluster" "my_cluster" {
  project_id = mongodbatlas_project.my_project.id
  name       = "my-m10-cluster"
  
  provider_name = "AWS" # or "GCP" or "AZURE"
  region_name   = "US_EAST_1" # Change to your preferred region
  cluster_type  = "REPLICASET"
  
  // M10 configuration
  disk_size_gb = 10
  num_shards    = 1
  replication_factor = 3

  // Optional settings
  backup_enabled = true

  // Optional: Configure additional settings
  mongo_db_major_version = "4.4" # Change to your desired version
  provider_instance_size_name = "M10" # Specify M10 instance size
}

resource "mongodbatlas_cluster" "my_cluster" {
  project_id = mongodbatlas_project.my_project.id
  name       = "my-m40-nvme-cluster"
  
  provider_name = "AWS" # or "GCP" or "AZURE"
  region_name   = "US_EAST_1" # Change to your preferred region
  cluster_type  = "REPLICASET"
  
  // M40 NVMe configuration
  disk_size_gb = 10  // Minimum size; adjust as needed
  num_shards    = 1
  replication_factor = 3

  // Enable NVMe storage
  provider_instance_size_name = "M40" // Specify M40 instance size
  storage_engine = "WiredTiger" // Default storage engine

  // Optional settings
  backup_enabled = true

  // Optional: Configure additional settings
  mongo_db_major_version = "5.0" // Change to your desired version
}



resource "mongodbatlas_alert_configuration" "disk_usage_alert" {
  project_id = mongodbatlas_project.my_project.id
  name       = "Disk Usage Alert"
  
  // Specify the alert type
  alert_type = "DISK_USAGE"
  // Set the threshold for the alert
  threshold = 80 // Trigger alert when disk usage exceeds 80%
  // Specify the notification settings
  notification {
    type = "EMAIL"
    email_address = "<YOUR_EMAIL_ADDRESS>" // Replace with your email
  }
  // Optional: Set the frequency of the alert
  frequency = "DAILY" // Options: "IMMEDIATE", "DAILY", "WEEKLY"
}
