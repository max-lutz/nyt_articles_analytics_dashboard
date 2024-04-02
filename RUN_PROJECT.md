


# Instructions

## Setup Google cloud account (5 min)

1. Connect to your google cloud account or create one
2. Create a new project
   ```
   PROJECT_ID="nyt-data-analytics-$(shuf -i 100000-999999 -n 1)"
   gcloud projects create $PROJECT_ID --name="nyt data project"
   gcloud config set project $PROJECT_ID
   ```

3. Set the region
   ```
   gcloud config set compute/region europe-west9
   gcloud config set compute/zone "$(gcloud config get compute/region)-b"
   GOOGLE_CLOUD_REGION=$(gcloud config get compute/region)
   GOOGLE_CLOUD_ZONE=$(gcloud config get compute/zone)
   ```

4. Activate APIs:
   ```
   gcloud services enable bigquery.googleapis.com storage-component.googleapis.com compute.googleapis.com
   ```


   ***Note:** If there is an error message, that a billing account is missing for this new project, follow these additional steps:*
   1. Go to the [Google Cloud Platform billing config](https://console.cloud.google.com/billing/projects).
   2. Click on the three dots next to the new project and select "Change billing". 
   3. Choose the billing account and confirm by clicking "Set account".
   4. Execute the shell command above again to enable the APIs.

5. Create a new service account [link]
   ```
   gcloud iam service-accounts create svc-admin-data-pipeline --display-name="Data pipeline Service Account" --project=$GOOGLE_CLOUD_PROJECT
   GCP_SA_MAIL="svc-admin-data-pipeline@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com"
   ```

   Add the necessary permissions
   ```
   gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member="serviceAccount:$GCP_SA_MAIL" --role='roles/bigquery.admin'
   gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member="serviceAccount:$GCP_SA_MAIL" --role='roles/storage.admin'
   gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member="serviceAccount:$GCP_SA_MAIL" --role='roles/compute.admin'
   ```

6. Create a new VM
   ```
   gcloud compute instances create instance-$PROJECT_ID --project=$PROJECT_ID --zone=$GOOGLE_CLOUD_ZONE --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=$GCP_SA_MAIL --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=instance-$PROJECT_ID,image=projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240307b,mode=rw,size=100,type=projects/$PROJECT_ID/zones/$GOOGLE_CLOUD_ZONE/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any
   ```

   Open port 6789
   ```
   gcloud compute firewall-rules create open-port-6789 --allow tcp:6789 --source-tags=instance-$PROJECT_ID --source-ranges=0.0.0.0/0 --description="open port 6789 of the vm"
   ```

7. Create service account key
   ```
   gcloud iam service-accounts keys create nyt_project.json --iam-account=$GCP_SA_MAIL

   gcloud compute scp nyt_project.json instance-$PROJECT_ID:~/.gc/nyt_project.json
   ```

8. Save env variables
   ```
   echo PROJECT_ID=$PROJECT_ID > env.env
   echo REGION=$GOOGLE_CLOUD_REGION >> env.env
   echo ZONE=$GOOGLE_CLOUD_ZONE >> env.env

   IP=gcloud compute instances describe instance-$PROJECT_ID --format='get(networkInterfaces[0].accessConfigs[0].natIP)' --zone $GOOGLE_CLOUD_ZONE
   echo IP=$IP >> env.env

   gcloud compute scp env.env instance-$PROJECT_ID:.env
   ```

9. Connect to the VM
   ```
   gcloud compute ssh --project=$PROJECT_ID --zone=$GOOGLE_CLOUD_ZONE instance-$PROJECT_ID
   ```
   

## Setup environment in VM (5 min)

1. [if needed] install git: 

   ```bash 
   sudo apt install git-all
   ```
2. Clone the repo
   ```bash
   git clone https://github.com/max-lutz/nyt_articles_analytics_dashboard.git
   ```

3. Run setup.sh

   Make setup.sh executable
   ```bash
   chmod +x ~/nyt_articles_analytics_dashboard/setup.sh
   ```
   Run setup.sh
   ```bash
   ~/nyt_articles_analytics_dashboard/setup.sh
   ```

4. Add environment variables to the environment
   ```
   export $(xargs < .env)
   ```

## Run project (5 min)

1. Setup infrastructure:
   ```
   cd ~/nyt_articles_analytics_dashboard/terraform

   terraform init 

   # change name of project and bucket.
   terraform plan -var="project=$PROJECT_ID" -var="gcs_bucket_name=bucket-$PROJECT_ID"

   # change name of project and bucket.
   terraform apply -var="project=$PROJECT_ID" -var="gcs_bucket_name=bucket-$PROJECT_ID"
   ```

2.  Run mage
      ```
      cd ~/nyt_articles_analytics_dashboard
      docker-compose up -b
      ```
   
      Connect to mage:
      
      ```
      echo "Connect to: http://$IP:6789"
      ```

