NAME=u241
limactl create --name $NAME --tty=false template://ubuntu-24.04
limactl start $NAME
limactl shell --workdir . $NAME bash setup.sh

