


# Instructions

## Setup Google cloud account (5 min)

1. Connect to your google cloud account or create one
2. Create a new project [link]
3. Create a new service account [link]
   1. Name it `admin_data_pipeline`
   2. Create key
4. Create a new VM [link]
   1. Name it nyt-data-pipeline
   2. Choose the region/zone you want
   3. 100 Gb disk space
5. Connect to the VM
   1. Click on SSH button

## Setup environment in VM (5 min)

1. [if needed] install git: 

   ```bash 
   sudo apt install git-all
   ```
2. Clone the repo
   ```bash
   git clone https://github.com/max-lutz/nyt_articles_analytics_dashboard.git
   ```

3. Add the google credentials
   1. In the VM upload the downloaded key you generated for the service account (it should be a json file)
   2. Move it to `~/.gc/nyt_project.json` for example 
      ```bash
      mv ~/nyt-data-analytics-676e51ac5bf8.json ~/.gc/nyt_project.json
      ```
4. Run setup.sh
   1. Make setup.sh executable
   ```bash
   chmod +x ~/nyt_articles_analytics_dashboard/setup.sh
   ```
   2. Run setup.sh
   ```bash
   ~/nyt_articles_analytics_dashboard/setup.sh
   ```

## Run project

1. Setup infrastructure:
```
cd ~/nyt_articles_analytcis_dashboard/terraform

terraform init 

# change name of project and bucket.
terraform plan -var="project=nyt-data-analytics" -var="gcs_bucket_name=nyt_data_analytics_bucket"

# change name of project and bucket.
terraform apply -var="project=nyt-data-analytics" -var="gcs_bucket_name=nyt_data_analytics_bucket"

```

1.  Run mage
```
cd ~/nyt_articles_analytcis_dashboard
docker-compose up
```

