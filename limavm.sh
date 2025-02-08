#! /usr/bin/bash

set -e

NAME=
OS=
VERSION=

help() {
    echo "Usage: $0 [options]"
    echo "-n Name of the VM"
    echo "-o OS/Distribution: ubuntu, almalinux"
    echo "-v Version"
    exit 1
}

while getopts "n:o:v:h" opt; do
case $opt in
    n)
        NAME=$OPTARG
        ;;
    o)
        OS=$OPTARG
        ;;
    v)
        VERSION=$OPTARG
        ;;
    h)
        help
        ;;
esac
done

if [[ $NAME == "" || $OS == "" || $VERSION == "" ]]; then
    help
fi

limactl create --name $NAME --tty=false template://$OS-$VERSION
limactl start $NAME
OS_SETUP_SCRIPT=https://raw.githubusercontent.com/maskiran/misc/refs/heads/main/$OS-setup.sh
limactl shell --workdir . $NAME curl -o setup.sh -fsSL $OS_SETUP_SCRIPT
limactl shell --workdir . $NAME bash setup.sh
