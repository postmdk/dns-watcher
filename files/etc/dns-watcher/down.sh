#!/bin/sh
FALLBACK_RESOLV="/tmp/resolv.conf.d/resolv.conf.fallback"

if [ ! -f "$FALLBACK_RESOLV" ]; then
    echo "nameserver 77.88.8.8" > "$FALLBACK_RESOLV"
fi

CURRENT_RESOLV=$(uci -q get dhcp.@dnsmasq[0].resolvfile)

if [ "$CURRENT_RESOLV" != "$FALLBACK_RESOLV" ]; then
    uci set dhcp.@dnsmasq[0].resolvfile="$FALLBACK_RESOLV"
    uci commit dhcp
    /etc/init.d/dnsmasq restart
    logger -t dns-watcher-hook "Switched to fallback DNS (77.88.8.8)."
fi
