# Update Hurricane Electric DDNS IPv4 address


:local ddnshost "Hostname of Mikrotik"
:local key "DDNS Key for hostname on dns.he.net site"
:local updatehost "dyn.dns.he.net"
:local WANinterfaces "WAN"
:local outputfile ("HE_DDNS" . ".txt")

# Internal processing below...
# ----------------------------------
:local ipv4addr

/tool fetch url="https://checkip.dns.he.net/" mode=https output=file dst-path="dyndns.checkip.html"
:local result [/file get dyndns.checkip.html contents]

# parse the current IP result
:local resultLen [:len $result]
:local startLoc [:find $result ": " -1]
:set startLoc ($startLoc + 2)
:local endLoc [:find $result "</body>" -1]
:local ipv4addr [:pick $result $startLoc $endLoc]
:log info "UpdateHEDNS: currentIP = $ipv4addr"
#End Get Public IP

:if ([:len $ipv4addr] = 0) do={
   :log error ("Could not get IP for interface " . $WANinterface)
   :error ("Could not get IP for interface " . $WANinterface)
}

:log info ("Updating DDNS IPv4 address" . " Client IPv4 address to new IP " . $ipv4addr . "...")

/tool fetch url="http://$ddnshost:$key@$updatehost/nic/update?hostname=$ddnshost&myip=$ipv4addr"  \
dst-path=$outputfile

:log info ([/file get ($outputfile) contents])
/file remove ($outputfile)
