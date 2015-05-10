# Automating Your EC2 Builds

***

## Jujhar Singh
 ### Lead Architect, Buto.tv
jujhar.singh@buto.tv, @jujhars13
![me](https://raw.githubusercontent.com/jujhars13/presentation-aws-user-group-2015-05/master/presentation/rsz_jujhar.png)

***

- Been working in IT since the age of 16
- Support -> DBA -> Dev -> IT manager -> developer -> DevOps
- From Windows NT 3.0 to Windows Server 2008
- From Fedora 2 to Ubuntu 15
- MS SQL Server 7->2005, MySQL and Mongo
- Deployed in Classic ASP, VB5, VB.NET & C# 1->3.5, Python and Go
- More PHP than I care to admit to. Mostly try to NodeJS (2 years)
- Production workloads on AWS since 2010


***

## About Buto

- Online video platform based in Digbeth and London
- We're like YouTube but for private businesses
- Some big name : Eversheds, TRW, RFU, Tescos, Freshfields, Amec ...
- Been on AWS for over 3 years, previously on Rackspace started on 1&1(Yuk!)
- Platform is mostly PHP with new stuff in Node and bits of Python, Go and C#
- Apache, HA Proxy, Redis, Mongo, MySQL, Memcache, CI(yuk!), Zend_Framework, Cilex, Express, Gearman, StatsD, Mesos and Docker

***

## Buto stats
(based on March 2015)
- ~1 million api requests per day
- ~280k player loads per day
- ~6k video plays per day

*** 

## Buto AWS Usage

- Monthly spend with AWS is about ~$4.5k production and ~$400 staging
- Save ~$600 pm by using reserved instances
- Save ~$1.5k pm by using autoscale and spot instances
- Use EC2, RDS, Elasticache, DynamoDB, Cloudwatch, Route53, SQS, S3 and Cloudfront
- Plan to use Kinesis, Lambda, Redshift, Data Pipeline, Cloudsearch and EC2 Container Service

***
cont...
- Run ~43 production servers up to 50+ during peaks
- Use >20TB of S3 storage
- Use 1TB of IO optimised RDS storage over 6 MySQL instances
- Transfer out \>2TB pm from EC2 and 9.5TB pm via CloudFront
- ~40 - 50k messages in and out of SQS per day
- Use a mixture of C3's and M3's, still some T1s
- Plan to make more use of VPC and CloudFormation to be cross region


***

## Why did we automate?

- Infrastructure as code (versioned, recorded, testable)
- Ephemeral builds, no longer attached to servers
- More secure
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
  - You can then use to setup tools of your choice: Chef, Puppet, Ansible...

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
curl -ksS https://svr.btolabs.tv/base.sh || sh
curl -ksS https://svr.btolabs.tv/firewall.sh || sh 22,80,443
curl -ksS https://svr.btolabs.tv/post.sh || sh
echo "All install finished on `date`" >>$BUTO_LOG_SETUP
```

***

## Your turn

- Setup Account and login
- Generate an SSH key
- Create your build script
- configure security group
- Build deps (NodeJS)
- Yank
- Serve app

## Hints

If you get stuck build your box first and test all your commands out first, then add them to your script.
- `yum update -y`
- install git
- install node
- set `NODE_PORT` either in global env or just before you run command
- code in demo dir: [http://git.io/vU3mW](http://git.io/vU3mW)
- If lazy you can just use `python -m SimpleHTTPServer`
***

## Extras
(if we have time)
- use autoscaling groups for spot instance bids
- Setup and test autoscale based on server load
- Docker web service