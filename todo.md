# Todo
- Create staging and production datasets in bigquery using terraform
- add more tests on the data in ETL pipeline and dbt
- add trigger on ETL pipeline
    - loop through all the possible years and months
- use cloud shell to create the vms, IAM role and firewall rule
    - create service account: https://cloud.google.com/sdk/gcloud/reference/iam/service-accounts/create
    - grant role to service account: https://cloud.google.com/sdk/gcloud/reference/iam/service-accounts/add-iam-policy-binding
    - expose port 6789 from the VM using a firewall (https://www.youtube.com/watch?v=aWk2Tivv8Zw)
- connect looker to bigquery
    - see if we can do it using cloud shell

- run test from scratch
    - test if we can improve the user experience to run the project
        - gc json key
        - project name...