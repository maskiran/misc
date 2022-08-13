repos=(
aws-vpc
aws_sns_http_subscriber
misc
pytest
react-antd-itemslist
react-antd-object-table
react-antd-template
sample-web-app
sbf-api
sbf-ui
taurus
terraform-aws-app-vpc
terraform-azure-app-vnet
terraform-gcp-app-vpc
)

for repo in ${repos[@]}; do
    echo git clone git@github.com:maskiran/${repo}.git
done
