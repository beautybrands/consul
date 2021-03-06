#!/bin/sh

rm /etc/dnsmasq.conf
cp /etc/dnsmasq.conf.template /etc/dnsmasq.conf

CONSUL_HOST=`getent hosts consul | awk '{ print $1 }'`
sed -i "s/CONSUL_HOST/$CONSUL_HOST/" /etc/dnsmasq.conf

NGINX_HOST=`getent hosts consul_nginx | awk '{ print $1 }'`
if [ "$WSL" == '1' ]; then
    # NGINX_HOST=`echo $ETH0_IP`
    NGINX_HOST=`echo 127.0.0.1`
fi

sed -i "s/NGINX_HOST/$NGINX_HOST/" /etc/dnsmasq.conf

webproc --config /etc/dnsmasq.conf -- dnsmasq --no-daemon