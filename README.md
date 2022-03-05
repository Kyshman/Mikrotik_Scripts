Mikrotik Scripts
========

Some (possibly useful) Mikrotik RouterOS scripts

Updating Hurricane Electric Free DNS via DDNS
=============================================

**If you use a Terminal**

You should first create a new system script using the following commands:

- *Remember to change the owner to the correct USERNAME of the script's creator - Usually admin or the username you use to login to the Mikrotik*

```
/system script add name="HE-DDNS" owner=tony \
comment="Script to update Hurricane Electric DDNS" \
policy=read,write,test source="PASTE CONTENTS OF DDNS_he.net.rsc HERE"
```
Add a scheduler that calls the script every 5 minutes to send an update when IP changes.

```
/system scheduler add comment="Update DDNS" interval=5m name=ddns_scheduler \
on-event="/system script run HE-DDNS\r\n" policy=read,write,test start-time=startup  
```

With the assistance of [Dyndns.org](https://ddns.org/docs/1.0/ddns-configuration-mikrotik)
