set -x
vpc=$1

SUBNETS=$(aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpc | jq -r '.Subnets[].SubnetId')
for item in $SUBNETS; do
    aws ec2 delete-subnet --subnet-id $item
done

RTBLS=$(aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpc | jq -r '.RouteTables[].RouteTableId')
for item in $RTBLS; do
    aws ec2 delete-route-table --route-table-id $item
done

SGS=$(aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc | jq -r '.SecurityGroups[].GroupId')
for item in $SGS; do
    aws ec2 delete-security-group --group-id $item
done

IGW=$(aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc | jq -r .'InternetGateways[].InternetGatewayId')
if [ "$IGW" != "" ]; then
    aws ec2 detach-internet-gateway --internet-gateway-id $IGW --vpc-id $vpc
    aws ec2 delete-internet-gateway --internet-gateway-id $IGW
fi

aws ec2 delete-vpc --vpc-id $vpc
