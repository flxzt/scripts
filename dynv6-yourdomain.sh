#!/bin/sh -e
token="yourtoken"
netmask="64"
hostname="yourdomain.net"
device="eth0"

file=$HOME/.dynv6_$hostname.addr6
[ -e $file ] && old=`cat $file`

if [ -z "$netmask" ]; then
  netmask=128
fi

if [ -n "$device" ]; then
  device="dev $device"
fi
address=$(ip -6 addr list scope global $device | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)

if [ -e /usr/bin/curl ]; then
  bin="curl -fsS"
elif [ -e /usr/bin/wget ]; then
  bin="wget -O-"
else
  echo "neither curl nor wget found"
  exit 1
fi

if [ -z "$address" ]; then
  echo "no IPv6 address found"
  exit 1
fi

# address with netmask
current=$address/$netmask

if [ "$old" = "$current" ]; then
  echo "IPv6 address unchanged"
  exit
fi

# send addresses to dynv6
$bin "https://dynv6.com/api/update?hostname=$hostname&ipv6=$current&token=$token"
echo " "
$bin "https://ipv4.dynv6.com/api/update?hostname=$hostname&ipv4=auto&token=$token"
echo " "
# save current address
echo $current > $file
