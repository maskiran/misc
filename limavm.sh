NAME=u24
OS=ubuntu-24.04

limactl create --name $NAME --tty=false template://$OS
limactl start $NAME
limactl shell --workdir . $NAME curl -o setup.sh -fsSL https://raw.githubusercontent.com/maskiran/misc/refs/heads/main/ubuntu-setup.sh
limactl shell --workdir . $NAME bash setup.sh

