#!/bin/sh
AUTO_RESOLV="/tmp/resolv.conf.d/resolv.conf.auto"
CURRENT_RESOLV=$(uci -q get dhcp.@dnsmasq[0].resolvfile)

if [ "$CURRENT_RESOLV" != "$AUTO_RESOLV" ]; then
    uci set dhcp.@dnsmasq[0].resolvfile="$AUTO_RESOLV"
    uci commit dhcp
    /etc/init.d/dnsmasq restart
    logger -t dns-watcher-hook "Switched to primary DNS (auto)."
fi
