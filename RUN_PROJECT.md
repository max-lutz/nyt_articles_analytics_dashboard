


# Instructions

## Setup Google cloud account (5 min)

1. Connect to your google cloud account or create one
2. Create a new project [link]
3. Create a new service account [link]
   1. Name it `admin_data_pipeline`
   2. Create key
4. Create a new VM [link]
   1. Name it nyt-data-pipeline
   2. In the region/zone you want
   3. 100 Gb disk space
   4. No service account to connect
5. Connect to the VM
   1. Click on SSH button

## Setup environment in VM

1. Install git: `sudo apt install git-all`
2. Run setup.sh