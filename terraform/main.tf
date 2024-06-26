terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}



resource "google_bigquery_dataset" "raw_dataset" {
  dataset_id = var.bq_dataset_raw_name
  location   = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "staging_dataset" {
  dataset_id = var.bq_dataset_staging_name
  location   = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "production_dataset" {
  dataset_id = var.bq_dataset_production_name
  location   = var.location
  delete_contents_on_destroy = true
}