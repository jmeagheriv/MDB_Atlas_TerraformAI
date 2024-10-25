
resource "mongodbatlas_cluster" "my_m10_cluster" {
  project_id   = "YOUR_PROJECT_ID"
  name         = "MyM10Cluster"
  cluster_type = "REPLICASET"
  provider_name = "AWS" # or "GCP", "AZURE" based on your choice
  provider_region_name = "US_EAST_1" # Your preferred region
  num_shards   = 1
  replication_factor = 3
  provider_instance_size_name = "M10"
  mongo_db_major_version = "4.2" # or another preferred version

  auto_scaling_disk_gb_enabled = true
  backup_enabled               = true
}
resource "mongodbatlas_cluster" "my_m40_nvme_cluster" {
  project_id   = "YOUR_PROJECT_ID"
  name         = "MyM40NVMeCluster"
  cluster_type = "REPLICASET"
  provider_name = "AWS" # or "GCP", "AZURE" based on your choice
  provider_region_name = "US_WEST_2" # Your preferred region
  num_shards   = 1
resource "mongodbatlas_alert_configuration" "backup_alert" {
  project_id = "YOUR_PROJECT_ID"
  event_type = "BACKUP"
  enabled    = true

  matcher {
    field_name = "TYPE_NAME"
    operator   = "EQUALS"
    value      = "CLUSTER"
  }

  notification {
    type_name   = "EMAIL"
    interval_min = 5
    delay_min    = 0
    email_address = "your-email@example.com"
  }
}
