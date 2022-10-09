# Objectives
## Create an S3 Bucket and a Static Website

Create an S3 bucket for our assigned domain, configure a static website for the domain, and set up a DNS record (called an  `A`  or  `alias`  record) in Route 53. Make sure that in the  _Object Ownership_  section, check  `ACLs enabled`.

## Configure a Custom Domain in Route 53

Create a redirect (_www_) S3 bucket and configure a redirect DNS record to point to our AWS S3 static site.

## Test the Static Website with `dig` and `nslookup` Commands

Open our instant terminal and run the  `dig`  and  `nslookup`  commands to verify our website is routed properly.
