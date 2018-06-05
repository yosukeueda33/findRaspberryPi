#!/bin/bash

echo "This tool lists up ip address of raspberry pis in same subnet."

# Select interface by using ifconfig command.
iface="eno1"
echo "Target interface  : $iface"

myIP=$(ifconfig $iface | awk '/inet /{print $2}')
echo "My ip address     : $myIP"
netmask=$(ifconfig $iface | awk '/inet /{print $4}')
echo "My net mask       : $netmask"

IFS=. read -r i1 i2 i3 i4 <<< $myIP;
IFS=. read -r m1 m2 m3 m4 <<< $netmask;
networkAddress=$(printf "%d.%d.%d.%d\n" "$((i1 & m1))" "$((i2 & m2))" "$((i3 & m3))" "$((i4 & m4))");

echo "NetworkAddress    :$networkAddress"

echo ""
echo "----Result----"
#exit 0
fping -a -r1 -g $networkAddress/24  &> /dev/null
arp -n | fgrep " b8:27:eb"
