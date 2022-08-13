#! /bin/bash

# root organization id under which the new accounts are added
root_ou_id=""

# sub folder ou name
ou_name="test-accounts"

# account name prefix
account_prefix="test"

# account email prefix
account_email_prefix="test"

# account email domain
account_email_domain="gmail.com"

echo "Create Organizational Unit $ou_name"
aws organizations create-organizational-unit \
    --parent-id $root_ou_id \
    --name $ou_name &> /dev/null

org_unit=$(aws organizations list-organizational-units-for-parent \
    --parent-id $root_ou_id | jq -r ".OrganizationalUnits[] | select(.Name == \"$ou_name\") | .Id")

creds_file=/tmp/credentials
echo "" > $creds_file

# create 10 accounts within the ou
for i in {1..10}; do
    number=$(printf "%03d" $i)
    account_name="$account_prefix-$number"
    root_account_email="$account_email_prefix+$number@$account_email_domain"
    iam_user_name="$account_email_prefix+${number}iam@$account_email_domain"
    # create account
    echo "Create AWS account $account_name"
    request_id=$(aws organizations create-account \
        --email $root_account_email \
        --account-name $account_name | jq -r .CreateAccountStatus.Id)
    sleep 5
    account_id=$(aws organizations describe-create-account-status \
        --create-account-request-id $request_id | jq -r .CreateAccountStatus.AccountId)
    echo "Move AWS account $account_name to the OU $ou_name"
    aws organizations move-account --account-id $account_id \
        --source-parent-id $root_ou_id \
        --destination-parent-id $org_unit
    
    # new account created, org would have created a cross account iam role
    assume_role_arn=arn:aws:iam::${account_id}:role/OrganizationAccountAccessRole
    echo "Assume role for the new created AWS account $account_name/$account_id"
    CREDS=$(aws sts assume-role \
        --role-arn $assume_role_arn --role-session-name AssumedRole$account_id)
    export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
    if [ "$AWS_ACCESS_KEY_ID" != "" ]; then
        echo "Create IAM users for the account $account_name/$account_id"
        user=$(aws iam create-user --user-name $iam_user_name)
        user_policy=$(aws iam attach-user-policy \
            --policy-arn arn:aws:iam::aws:policy/AdministratorAccess \
            --user-name $iam_user_name)
        user_password=$(aws iam create-login-profile \
            --user-name $iam_user_name \
            --password 2RJif-3_bXoD \
            --no-password-reset-required)
        op=$(aws iam create-access-key --user-name $iam_user_name)
    fi
    echo "[$account_name]" >> $creds_file
    echo "aws_access_key_id = $(echo $op | jq -r '.AccessKey.AccessKeyId')" >> $creds_file
    echo "aws_secret_access_key = $(echo $op | jq -r '.AccessKey.SecretAccessKey')" >> $creds_file
    echo "account_number = $account_id" >> $creds_file
    echo "console_user = $(echo $user | jq -r '.User.UserName')" >> $creds_file
    echo "" >> $creds_file
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
done

cat $creds_file
