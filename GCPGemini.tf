resource "mongodbatlas_cluster" "m10_cluster" {
  name        = "my-m10-cluster"
  cluster_tier = "M10"
  region      = "US_EAST_1"
  provider    = "AWS"

  # Optional configurations:
  disk_size_gb = 100
  replication_factor = 3
  num_shards = 3
  auto_scaling_compute_max_instance_size = "M10"
  auto_scaling_compute_min_instance_size = "M10"
  backup_enabled = true
  backup_frequency = "DAILY"
  continuous_backup = true
  encryption_at_rest_provider = "AWS_KMS"
  encryption_at_rest_kms_key_id = "your_kms_key_id"
}

resource "mongodbatlas_cluster" "m40_nvme_cluster" {
  name        = "my-m40-nvme-cluster"
  cluster_tier = "M40-NVME"
  region      = "US_EAST_1"
  provider    = "AWS"

  # Optional configurations:
  disk_size_gb = 200
  replication_factor = 3
  num_shards = 3
  auto_scaling_compute_max_instance_size = "M40-NVME"
  auto_scaling_compute_min_instance_size = "M40-NVME"
  backup_enabled = true
  backup_frequency = "DAILY"
  continuous_backup = true
  encryption_at_rest_provider = "AWS_KMS"
  encryption_at_rest_kms_key_id = "your_kms_key_id"
  storage_engine = "WiredTiger"  // Optional, default is WiredTiger
}

resource "mongodbatlas_alert" "high_cpu_alert" {
  name        = "High CPU Usage Alert"
  project_id  = "your_project_id"
  cluster_name = "your_cluster_name"
  event_type  = "DATABASE"
  metric_name = "CPU"
  operator    = "GREATER_THAN"
  threshold    = 80
  notification_channels = [
    "EMAIL"
  ]
  notification_emails = [
    "your_email@example.com"
  ]
}
