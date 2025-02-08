NAME=u241
limactl create --name $NAME --tty=false template://ubuntu-24.04
limactl start $NAME
limactl shell $NAME curl -o setup.sh https://raw.githubusercontent.com/maskiran/misc/refs/heads/main/ubuntu-setup.sh
limactl shell $NAME bash setup.sh
limactl shell $NAME sudo reboot
