ip netns add myrouter
ip netns exec myrouter ip link # should show empty interfaces
ip link set dev ens6 netns myrouter # move int to namespace
ip link set dev ens7 netns myrouter # move int to namespace
ip netns exec myrouter ip link # check 2 ints
ip netns exec myrouter ip link set ens6 up
ip netns exec myrouter ip link set ens7 up
ip netns exec myrouter ip addr add <frontend-nic-ip>/24 dev ens6 # add ip to the nic
ip netns exec myrouter ip addr add <backend-nic-ip>/24 dev ens7 # add ip to the nix
ip netns exec myrouter ip route add 0.0.0.0/0 via 172.16.0.1 # 172.16.0.1 is the backend gateway attached to the backend-nic-ip
ip netns exec myrouter sysctl -w net.ipv4.conf.ens6.rp_filter=0 # disable rp filter to accept all packet
ip netns exec myrouter sysctl -w net.ipv4.conf.ens7.rp_filter=0
sysctl -w net.ipv4.conf.all.rp_filter=0 # this may not be required, but just setting it up
