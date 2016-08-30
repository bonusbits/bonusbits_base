# Bonus Bits Base Cookbook
[![Build Status](https://travis-ci.org/bonusbits/bonusbits_base.svg?branch=master)](https://travis-ci.org/bonusbits/bonusbits_base)
[![Circle CI](https://circleci.com/gh/bonusbits/bonusbits_base/tree/master.svg?style=shield)](https://circleci.com/gh/bonusbits/bonusbits_base/tree/master)
[![Coverage Status](https://coveralls.io/repos/bonusbits/bonusbits_base/badge.svg?branch=master&service=github)](https://coveralls.io/github/bonusbits/bonusbits_base?branch=master)

# Purpose
Chef Cookbook that will setup the basics for various flavors of Linux and Windows Servers.
Be sure to set appropriate overrides for what you do and don't want to be setup in your environment files.
This is a great starting point for all your nodes. It's also a great example for writing wrapper cookbooks.

The secondary purpose of this cookbook is to give various examples that can be replicated in other cookbooks. I did my best to include all the major coding and testing scenarios.

# Supported Platforms
* Linux
    * Amazon (EC2 Only - Coming Soon)
    * RHEL (EC2 Only)
    * CentOS
    * Ubuntu
* Windows (EC2 Only)
    * 2012 R2 (Cookbook items WIP. Kitchen just spins up an instances currently.)

# Successfully Tested Versions
VirtualBox 5.1 and Vagrant 1.8.5 currently have problems. Downgrade to the specific versions listed below until things stabilize. 
Also, I found as of the latest Chef client version 12.12.5 chef_solo does not exactly replicate chef_zero. Meaning chef_zero allows environment files whereas chef_solo did not.

* Mac OSX (10.11.6)
* Docker (1.11.2)
* VirtualBox (5.0.26)
* Vagrant (1.8.4)
    * Plugins
        * vagrant-vbguest (0.11.0)
        * vagrant-winrm (0.7.0)
* Chef Development Kit (0.17.17)
    * Ruby (2.1.8p440)
    * Chef-client (12.13.37)
    * Inspec (0.29.0)
    * berkshelf (4.3.5)
    * rubocop (0.39.0)
    * foodcritic (7.0.1)
    * test-kitchen (1.11.1)
        * serverspec (2.36.0)
    * kitchen-ec2 (1.1.0)
* Additional Gems
    * kitchen-docker (2.5.0)
    * vagrant-wrapper (2.0.3)
    * winrm-transport (1.0.3)

# Features
* Setup a virtual machine/s for testing on VirtualBox, Docker or AWS EC2.
* Install packages.
    * I put a few basic packages I like, but you can override the array.
* Option to setup proxy on VirtualBox VM
* Locks down iptables to the minimum.
    * Open each port as need with next level wrapper cookbooks.
* Change Ruby Gem source for Chef client embedded Ruby to an internal mirror/source.
* Create a small script for displaying useful information when on the VM called **nodeinfo**
    * It should be in the default path by design.
    * Type nodeinfo <enter> to get a short list of node information.

# JSON Chef Config Files
I've created environment, roles and data bag items JSON files under the test folder.
These are called by the Test Kitchen YAML configuration files instead of entering all the attribute overrides inside the YAML.
It cleans up the kitchen YAML, plus makes it easier to quickly understand how you'd setup these Chef configurations in your environment.
Basically copy/paste, instead of converting YAML to JSON... I've done it for you!

```
test
├── data_bags
│   ├── encrypted_data_bag_secret
│   └── bonusbits_base
│       ├── credentials.json
│       └── enterprise_ca.json
├── environments
│   └── bonusbits_base.json
└── roles
    └── base.json
```

The data bag items are just examples. They are not currently used in the cookbook.
I added it mainly for when I copy/paste to write a new wrapper it's already staged for me.
I usually end up adding the customers CA cert chain as part of my base cookbook.
[Here's](https://www.bonusbits.com/wiki/HowTo:Add_Internal_Root_CA_to_CentOS_and_Chef_Client) some information on how to accomplish that task.

#Kitchen Configurations
The default Kitchen configuration ```.kitchen.yml``` is setup using the Vagrant driver. There are other Kitchen configurations for Docker and EC2 as seen below.

To call another kitchen YAML is fairly easy and can be aliased to make it even easier.

| Driver | Command |
| :--- | :--- |
| VirtualBox - Vagrant | ```kitchen <command>``` |
| EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen <command>``` |
| Docker | ```KITCHEN_YAML=.kitchen.docker.yml kitchen <command>``` |

### Command Examples
The kitchen commands need to be ran from the root directory of the cookbook.

| Task | Driver | Command |
| :--- | :--- | :--- |
| List All Test Suites | VirtualBox | ```kitchen list``` |
| List All Test Suites | EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen list``` |
| List All Test Suites | Docker | ```KITCHEN_YAML=.kitchen.docker.yml kitchen list``` |
| Run Chef on a Single Test Suite | EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen converge base-centos-72```| 
| Run Integration Tests with ServerSpec on a Single Test Suite | Docker | ```KITCHEN_YAML=.kitchen.docker.yml kitchen verify base-centos-511``` |
| Test all Test Suites (destroy, create, converge, setup, verify and destroy) | VirtualBox | ```kitchen test``` | 
| Login to a Single Test Suite That is Already Created | EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen login base-centos-67``` |
| Login to a Single Test Suite That is Already Created | Docker | ```KITCHEN_YAML=.kitchen.docker.yml kitchen login base-centos-67``` |
| Login to a Single Test Suite That is Already Created | EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen login base-centos-67``` |
| Run a Command on a Single Test Suite That is Already Created | VirtualBox | ```kitchen exec base-centos-67 -c '/bin/nodeinfo'``` | 
| Destroy a Single Test Suite That is Already Created | VirtualBox | ```kitchen destroy base-centos-67```| 
| Create and Verify a Windows 2012 R2 EC2 Instance | EC2 | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen verify base-windows-2012r2```| 

# EC2 Requirements
1. Direct Connect / VPN
    * A direct connect or VPN solution must be in place from you to the AWS VPC where you plan to stand up EC2 instances.
2. NAT or IGW 
    * The subnet that you plan to stand up the EC2 instances in will need internet access to download Chef and Gem items.
3. AWS Credentials Profile Configured
    * Be sure to setup your AWS CLI profile even if you only have one. It's a more secure method to pass credentials to Test Kitchen.
    ```bash
    aws configure
    vim ~/.aws/config
    vim ~/.aws/credentials
    ```
4. Environment Variables
    * Set these Environment Variables or use .kitchen.local.yml config to overwrite the values with static personal information.
    ```
    AWS Environment Variables
    -----------------------------------------
    AWS_SSH_KEY_ID = {aws ssh key name}
    AWS_SSH_KEY_PATH = {/path/to/sshkey.pem}
    AWS_PROFILE = {aws config profile name}
    AWS_REGION = {us-west-2 or us-east-1}
    AWS_SECURITY_GROUP_1 = {security group ID}
    AWS_SECURITY_GROUP_2 = {security group ID}
    AWS_SUBNET = {subnet ID to deploy}
    AWS_VPC_ID = {VPC ID to deploy}
    AWS_IAM_ROLE = {EC2 Instance IAM Profile Role Name}
    ```

# NodeInfo Script
You can run the nodeinfo script locally or use Test Kitchen to run it. You can have it run on one, multiple or all of the test suite VMs you have running.
Below are some examples:

## Example Output
```---------------------------------------------------------------
Node Informaiton
---------------------------------------------------------------
IP Address:           (10.0.4.188)
Hostname:             (ip-10-0-4-188)
FQDN:                 (ip-10-0-4-188.us-west-2.compute.internal)
Platform:             (redhat)
Platform Version:     (6.8)
CPU Count:            (1)
Memory:               (994MB)
Detected Environment: (dev)
Chef Environment:     (_default)
Chef Roles:           ([base])
Chef Recipes:         ([bonusbits_base, bonusbits_base::default])
---------------------------------------------------------------
 ```
 
```---------------------------------------------------------------
Node Information
---------------------------------------------------------------
IP Address:           (10.0.4.167)
Hostname:             (WIN-SSKQF9C3VCF)
FQDN:                 (WIN-SSKQF9C3VCF)
Platform:             (windows)
Platform Version:     (6.3.9600)
CPU Count:            (1)
Memory:               (3839MB)
Detected Environment: (dev)
Chef Environment:     (bonusbits_base)
Chef Roles:           (["base"])
Chef Recipes:         (["bonusbits_base", "bonusbits_base::default"])
---------------------------------------------------------------
```
 
## Command Examples
| Task | Command |
| :--- | :--- |
| Vagrant Base CentOS 6.7 | ```kitchen exec base-centos-67 -c '/usr/bin/nodeinfo'``` | 
| All Running CentOS Vagrant Virtualbox VMs | ```kitchen exec centos -c '/usr/bin/nodeinfo'``` | 
| RHEL 7 EC2 Instance | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen exec base-rhel-7 -c '/usr/bin/nodeinfo'``` |
| Windows 2012R2 EC2 Instance | ```KITCHEN_YAML=.kitchen.ec2.yml kitchen exec base-windows-2012r2 -c 'C:/Windows/System32/nodeinfo.cmd'``` |

# Network Proxy
I have stubbed out proxy support in the kitchen configuration yaml files and a temp workaround for local "Virtualbox" VMs.
Usually you don't have to deal with a proxy issue in AWS. The defaults I have assume you are using [Charles Proxy](https://www.bonusbits.com/wiki/HowTo:Configure_Test_Kitchen_to_Use_Charles_Proxy), but you can override the attributes and change the kitchen configs to your own settings.
Keep in mind if you are not using Charles Proxy and pointing your BASH/PowerShell to it, you'll need to configure them as well.

## Enable Proxy in Kitchen Config
Simply un-comment the lines I have excluded in the .kitchen.yml or create a ```.kitchen.local.yml``` that doesn't get committed and add your custom settings.
Know that when you use the ```.kitchen.local.yml```, that an entire section is overroad by it. So you can't just try to add one override say under 'driver'.
Your local kitchen file has to contain the whole driver section that includes your changes.

```yaml
driver:
  name: vagrant
  customize:
    memory: 512
    cpus: 1
    natdnshostresolver1: "on"
    natdnsproxy1: "on"
  driver_config:
    ssl_verify_mode: ":verify_none"

provisioner:
  name: chef_solo
  require_chef_omnibus: 12.12.15
  client_rb:
    ssl_verify_mode: ":verify_none"
  data_bags_path: "test/data_bags"
  encrypted_data_bag_secret_key_path: "test/data_bags/encrypted_data_bag_secret"
  roles_path: "test/roles"
  environments_path: "test/environments"
   http_proxy: http://10.0.2.2:8888
   https_proxy: http://10.0.2.2:8888
   ftp_proxy: http://10.0.2.2:8888
   no_proxy: "localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com"
```


# Ruby Gem Source
If you don't have internet access you'll need an internal Rubygem repo source with the neccessary gems to run the integration tests. I have add logic with attributes to set an internal Ruby gem source.

# Resources

## Setup DevOps Workstation

* [Setup Mac DevOps Workstation](http://www.bonusbits.com/wiki/Reference:Mac_OS_DevOps_Workstation_Setup_Check_List)
* [Setup Ubuntu DevOps Workstation](http://www.bonusbits.com/wiki/Reference:Ubuntu_DevOps_Workstation_Setup_Check_List)
* [Setup Windows DevOps Workstation](http://www.bonusbits.com/wiki/Reference:Windows_DevOps_Workstation_Setup_Check_List)

## Test Kitchen

* [Test Kitchen Official Web Site](http://kitchen.ci/)
* [Test Kitchen Github](https://github.com/test-kitchen/test-kitchen)
* [Test Kitchen Chef Docs](https://docs.chef.io/kitchen.html)
* [Install Test Kitchen](https://www.bonusbits.com/wiki/HowTo:Install_Test_Kitchen)
* [Setup Test Kitchen](https://www.bonusbits.com/wiki/HowTo:Setup_Test_Kitchen)
* [Setup Test Kitchen for AWS EC2 Support](https://www.bonusbits.com/wiki/HowTo:Setup_Test_Kitchen_for_AWS_EC2_Support)
* [Test Kitchen Usage](https://www.bonusbits.com/wiki/Reference:Test_Kitchen)
* [Configure Test Kitchen to Use Charles Proxy](https://www.bonusbits.com/wiki/HowTo:Configure_Test_Kitchen_to_Use_Charles_Proxy)
* [Setup Test Kitchen in a Chef Cookbook](https://www.bonusbits.com/wiki/HowTo:Setup Test Kitchen in a Chef Cookbook)

## Chef
* [Getting Started with Chef Training Video](https://youtu.be/E0q4nIZ5QXg)
* [Add Internal Root CA to Linux Chef Client](https://www.bonusbits.com/wiki/HowTo:Add_Internal_Root_CA_to_CentOS_and_Chef_Client)
