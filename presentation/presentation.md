# Automating Your EC2 Builds

***

## Jujhar Singh

- Been working in IT since the age of 16
- Support -> DBA -> Dev -> ex IT manager -> developer -> DevOps
- From Windows NT 3.0 to Windows Server 2008
- From Fedora 2 to Ubuntu 15
- MS SQL Server 7->2005, MySQL and Mongo
- Deployed in Classic ASP, VB5, VB.NET & C# 1->3.5, Python and Go
- More PHP than I care to admit to. Mostly try to NodeJS (2 years)
- Production workloads on AWS since 2010

![me](https://dl.dropboxusercontent.com/u/12448/Jujhar.png)
***

## About Buto

- Online video platform based in Digbeth and London
- We're like YouTube but for private businesses
- Some big name clients: Eversheds, TRW, RFU, Tescos, Freshfields, Amec and some big name financial firms
- Been on AWS for over 3 years, previously on Rackspace started on 1&1(Yuk!)
- Platform is mostly PHP with new stuff in Node and bits of Python & Go
- Apache, HA Proxy, Redis, Mongo, MySQL, Memcache, CI(yuk!), Zend_Framework,Cilex, Express, Gearman, StatsD, Mesos and Docker

***

## Buto AWS stats
(based on March 2015)
- Monthly spend with AWS is about ~$5k production and ~$400 staging
- Save about $600 pm by using reserved instances
- Save about $1.5k pm by using autoscale and spot instances
- Use EC2, RDS, Elasticache, DynamoDB, Route53, SQS, S3, Cloudfront
- Plan to use Kinesis, Lambda, Redshift, Data Pipeline, Cloudsearch and EC2 Container Service

***
cont...
- Run about 43 production boxes on avg
- Use 20TB of S3 storage
- Use 1TB of IO optimised RDS storage over 6 MySQL instances
- Transfer out 2TB pm from EC2 and 9.5TB pm via CloudFront
- Use a mixture of c3's and m3's, still some t1s
- Plan to make more use of VPC and CloudFormation to be cross region


***

## Why automate?

- Infrastructure as code (and all its benefits)
- Dev, Staging and production are the same
- Testing is way easier
- Autoscaling
- Spot Instances

***

## How to Automate EC2 Builds

- CloudFormation
- AMIs
- Bundle Tasks (for Windows)
- EC2 User data scripts (web interface/command line):
  - Simple Bash start
  - You can then tools of your choice: Chef, Puppet, Ansible

***

## Example user data script

```
#!bin/bash
set -e -x
if [ $(wget -q -O - http://169.254.169.254/latest/meta-data/public-keys/) == "0=butolabs" ]; then
    export STAGING=true
else
    export STAGING=false
fi
export BUTO_LOG_SETUP=/var/log/buto-setup.log
export INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
export BUTO_MACHINE_NAME=cool-server.butolabs.tv
```

***
## Example user data script cont...

```
echo "Starting buto server install `date`" >$BUTO_LOG_SETUP
curl -ksS https://server-setup.butolabs.tv/base-configuration.sh >/root/base-configuration.sh || sh
curl -ksS https://server-setup.butolabs.tv/base-firewall.sh || sh 22,80,443
curl -ksS https://server-setup.butolabs.tv/post-install.sh || sh
echo "All install finished on `date`" >>$BUTO_LOG_SETUP
```
