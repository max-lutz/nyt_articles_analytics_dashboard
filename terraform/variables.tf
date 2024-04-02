variable "credentials" {
  description = "my credentials"
  default     = "~/nyt_project.json"
}

variable "project" {
  description = "project name"
  default     = "nyt-data-analytics"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "europe-west9"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "EU"
}

variable "bq_dataset_raw_name" {
  description = "raw dataset"
  #Update the below to what you want your dataset to be called
  default = "nyt_data"
}

variable "bq_dataset_staging_name" {
  description = "staging dataset"
  #Update the below to what you want your dataset to be called
  default = "staging"
}

variable "bq_dataset_production_name" {
  description = "production dataset"
  #Update the below to what you want your dataset to be called
  default = "production"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "nyt_data_analytics_bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}