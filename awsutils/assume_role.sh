# role that needs to be assumed
ROLE_ARN=""

# external id, if any for the above rule
EXT_ID=""

ROLE_NAME=$(echo $ROLE_ARN | cut -d/ -f2)
if [ "$EXT_ID" != "" ]; then
    EXT_ID="--external-id $EXT_ID"
fi

CREDS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name AssumedRole $EXT_ID)
export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
echo export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
echo export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
echo export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)

export AWS_PAGER=

echo "Current Identity"
aws sts get-caller-identity
echo "Listing inline role policies"
POLICY_NAMES=$(aws iam list-role-policies --role-name $ROLE_NAME | jq -r .PolicyNames[])
for pname in $POLICY_NAMES; do
    aws iam get-role-policy --role-name $ROLE_NAME --policy-name $pname
done
echo "Listing attached role policies"
POLICY_ARNS=$(aws iam list-attached-role-policies --role-name $ROLE_NAME | jq -r .AttachedPolicies[].PolicyArn)
echo $POLICY_ARNS
for policy_arn in $POLICY_ARNS; do
    aws iam get-policy --policy-arn $policy_arn
done
