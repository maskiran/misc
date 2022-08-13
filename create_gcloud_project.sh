#! /bin/bash

owners=(
    group:qa
)

# folder name underwhich the gcp projects are created
gcp_folder=1234444

# billing account to which the projects are linked
billing_account=012344555

for i in {2..50}; do
    number=$(printf "%03d" $i)
    project_name="test-$number"
    echo "Create gcp project $project_name"
    gcloud projects create $project_name --folder $gcp_folder &> /dev/null
    echo "Link the project to the billing account"
    gcloud beta billing projects link $project_name --billing-account $billing_account &> /dev/null
    echo "Assign owners to the project"
    for owner in ${owners[@]}; do
        gcloud projects add-iam-policy-binding $project_name \
            --member $owner@valtix.com --role roles/owner &> /dev/null
    done
done