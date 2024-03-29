## CHANGE LOG

## 3.0.3 - 10/04/2020 - Levon Becker
* Improved kitchen config
  * Removed env var defaults from kitchen config. If at a place where that makes since then can add, otherwise it's just confusing when you're missing an env var and it bombs with an odd error. This way it will be in your face that it's looking for an env var that is missing.
  * Updated Amazon Linux 1/2 AMI to latest
  * Updated Ubuntu 16/18 AMI to latest
  * Added Ubuntu 20.04 AMI

## 3.0.2 - 03/19/2020 - Levon Becker
* Renamed inspec_bonusbits_base repo to bonusbits_base_inspec in github. So, needed to updated audit and kitchen config
* Moved todo list to TODO.md

## 3.0.1 - 01/09/2020 - Levon Becker
* Changed node attributes json to cover all node hash so includes child cookbooks such as, bonusbits_mediawiki attributes that can be used for inspec tests.
    
## 3.0.0 - 01/07/2020 - Levon Becker
* Updated to ChefDK 4.5.0 - Chef Client 15.4.45 - Ruby 2.6.5
    * metadata.rb
    * Readme
    * Dockerfile
    * circle.yml
    * kitchen.yml
* Version Locked to latest Amazon Linux to v1 (el6) for Kitchen, CloudFormation and Dockerfile
* Refactored CloudFormation root keys to be alphabetical
* Added YAML anchors to the kitchen config
* Added environment variables fetch default examples in the kitchen config
* Updated Berksfile.lock
* Commented out test/* in chefignore
* Removed support suse drafts
* Merged bonusbits_library cookbook to this cookbook
* Moved logic from default attributes to discovery and helpers libraries
* Improved the shell library sensitive output control
* Moved .circle.yml to .circleci/config.yml
* Added Circleci Workflow
* Split Rakefile tasks into separate files under tasks directory
* Added Kubernetes deployment and service configurations
* Updated Inspec attributes
* Removed draft Windows support... not doing this any time soon, so drying up logic and sticking with Amazon Linux and Ubuntu
* Added Indicator library and resource for creating indicator files
* Added ec2_status attribute, recipe, library and resource for checking AWS EC2 Instance status
* Added helpers library to DRY up cookbook code
* Added Amazon Linux 2 as default in Kitchen, CloudFormation and Dockerfile
* Added option to select between Amazon Linux 1 or 2 in Kitchen, CloudFormation and Dockerfile
* Added logic to use lolcat gem if Amazon Linux 2 and package if v1
* Updated Java install / Inspec for Amazon Linux 1 & 2
* Removed Gemfile since not using bundler in CI anymore
* Switch boolean inputs in kitchen config for inspec profile to no have quotes since looks like they've finally fixed that issue of strings coming through to the inspec control inputs

## 2.3.0 - 10/28/2017 - Levon Becker
* Added OpenJDK Java Install Option for Linux
* Switched boolean inside_aws to ec2_deployment. Fits the logic better.
* Cleaned up kitchen config a bit
* Added kitchen test suite for installing Java
* Added more readme badges
* Updated Berkshelf lock file
* Workaround for Ohai Virtualization Plugin failing to detect Docker correctly.

## 2.2.4 - 08/26/2017 - Levon Becker
* Bumped ChefDK Version to 1.6.1 in CloudFormation and Dockerfile

## 2.2.3 - 08/26/2017 - Levon Becker
* Bumped Chef Client version to 12.21.4 (Latest v12 release)
* Added Berkshelf.lock to git commit to lock down dependent cookbook versions
* Added Gemfile.lock to again work around CircleCI / Gemfile million entries so the exact gems I've used locally are used in the CI
* Bumped Ruby version to 2.3.4 that comes with ChefDK 1.6.1 in Circle config
* Downgraded Rake version since ChefDK 1.6.1 seems to have dropped rake 12 and went to version 10.4/10.5? odd

## 2.2.2 - 08/26/2017 - Levon Becker
* Added Exclusions to backups
* Change Backup S3 bucket name to path
* Added an issues badge to readme

## 2.2.1 - 06/14/2017- Levon Becker
* Small tweak to RHEL Cloudwatch Logs setup logic so if in rare case can't download/run the first attempt. Then problem fixed and an attempt to run again it would get caught in condition hell and never move past step. Like if had a network issue or proxy setting issue. It downloads the setup script, but doesn't complete the setup properly. Before it would not try the setup again to correct and bomb on trying to start the service that was not setup yet.
* Cleaned up start/end time output in backup script
* Removed unused variable in backup script
* Removed UTC from time stamp and start/end times so matches system time

## 2.2.0 - 06/14/2017 - Levon Becker
* Updated Cloudwatch Logs logic for CentOS and RHEL support.
* Switched to using bonusbits_library shell library to DRY up some code
* Added Cookbook version badge to README
* Added backup to s3 logic
* Added Cloudwatch monitoring agent setup
* Added default aws region for testing some logic outside AWS
* Fixed awslogs additional logs logic for if nil

## 2.1.9 - 04/15/2017 - Levon Becker
* Removed unnecessary attributes in kitchen config now that auto deployment discovery wrote.
* Fixed CircleCI detection
* Conditioned Selinux to not run if Docker

## 2.1.8 - 04/15/2017 - Levon Becker
* Set to start awslogs at end of cloudwatch_logs recipe so it'll start streaming chef-client.log 

## 2.1.7 - 04/15/2017 - Levon Becker
* Switch Dockerfile to copy client.rb instead of creating it.
* Added restart notification to /etc/awslogs/awscli.conf template resource
* Added chef-client logging to client.rb for Docker
* Added Deployment section to nodeinfo
* Improved node content logic to dry up some code

## 2.1.6 - 04/15/2017 - Levon Becker
* Fixed CloudWatch Logs Config order so default with us-east-1 no longer left
* Added CloudWatch Logs /var/log/chef-client.log stream
* Added Client.rb updated to log chef run to /var/log/chef-client.log
* CFN: Renamed AMI map last key from EBS to amazon
* CFN: Removed role since just calling the recipe for run list and change chef run to call the recipe instead.

## 2.1.5 - 04/13/2017 - Levon Becker
* Upgraded and test with chefdk 1.3.40 / chef-client 12.19.36

## 2.1.4 - 04/10/2017 - Levon Becker
* Added windows cookbook dependent

## 2.1.3 - 04/10/2017 - Levon Becker
* Added /etc/sysconfig/network creation for Docker containers for Nginx type inits to work

## 2.1.2 - 04/10/2017 - Levon Becker
* Fixed missing period in detect environment logic
* Tweaked regex of rake tasks to be more flexible to test suite names

## 2.1.1 - 04/09/2017 - Levon Becker
* Switch kitchen shutdown to be true if deployed by kitchen and an EC2 instance. Still can be over-road in Environment/Node/Role.
* Changed default kitchen shutdown time to 6AM UTC/11PM PST/2AM EST
* Removed redundant package attribute
* Renamed packages attributes for package lists
* Added all attributes to table in README
* Added optional ssl **https** for Proxy URL
* Added optional user/password Proxy authentication

## 2.1.0 - 04/08/2017 - Levon Becker
* Switch kitchen-dokken to kitchen-docker because @someara says [not going to add support](https://github.com/someara/kitchen-dokken/issues/88) for CircleCi (lxc)
* ^^ ?? switch back and test in CircleCI 2.0 Beta ?? ^^
* Fixed yum updated exclude argument syntax
* Fixed InSpec attributes to be strings to deal with odd boolean randomly would or would't work.
* Converted from CircleCI 1.0 to 2.0 and got integration testing working!
* Created a Dockerfile and .dockerignore and updated README with info
* Created CloudFormation example and updated README with info
* Added Audit cookbook for running remote InSpec profiles on Docker local builds 
    * I'm guessing they will add inspec exec url support later, then I can ditch for that function
    * Should keep, add logic/test for reporting to Chef compliance, visibility servers
* Added some custom BASH profile MOTD stuff for fun
* Added Kitchen Shutdown option to have a scheduled cron shutdown/terminate an EC2 instance if forget it on over night etc.
* Added deployment_type, deployment_location and deployment_method detection in default attributes (WIP)
* Updated Amazon Linux version to 2017* in kitchen config

## 2.0.0 - 04/03/2017 - Levon Becker
* Changed logic around EPEL repo for Amazon Linux. By Default EPEL repo is setup. I could add removal logic later if desired.
* Bumped Chef Client Version to 12.19.36
* Added CloudWatch Logs configuration
* Switched from ServerSpec to InSpec
* Moved Inspec tests to profile repo so can be used by other cookbooks to check settings by this cookbook are correct [HERE](https://github.com/bonusbits/bonusbits_base_inspec)
* Updated Gemfile
* Removed Coverage badges
* Removed TravisCI sticking with CircleCi
* Added Gitter badge
* Added Draft CA Certs logic
* Drafted aws cli install for Redhat
* Switched EC2 driver as default kitchen config
* Added proxy option for CloudWatch Logs
* Expanded gem source logic
* Added EC2 info to Node Info Script
* Moved Node Info Script to /usr/local/bin/nodeinfo
* Added Sudoers secure path to include /usr/local/bin

## 1.2.0 - 10/30/2016 - Levon Becker
* Changed default to not include Firewall. So an override would be needed to include. Really these days it's usually handled at a different layer such and security groups. Plus it's been nothing but problems for testing in various environments.
* Added foodcritic exclusion to Rakefile for calling node method using key until they fix the rule to match Chef clients deprecation complaints
* Made Rubocop happy with too long of a line in Rakefile
* Switched from Docker Toolbox for Mac to Docker for Mac (native) because was getting crashes with Vbox version. So, had to Add use_sudo false in docker kitchen config for it to work correctly.

## 1.1.9 - 10/07/2016 - Levon Becker
* Added example Policyfile (WIP)
* Made node hash consistent
* Updated to Chef client 12.15.19, Ruby 2.3.1p112 and newer gems included in ChefDK 0.19.6
* Stripped down integration tests in Rakefile
* Tested CentOS 6.8
* Switched so regular repo installs before epel repo installed. Usually epel installs are addons to a standard package.
* Change detected environment logic to stop using deprecated node method call
* Fixed EC2 AMI Search for Amazon Linux

## 1.1.8 - 08/29/2016 - Levon Becker
* Improved Docker? method
* Removed the proxy test suites from EC2 and Docker Kitchen Config
* Removed Rubocop config to make CircleCI happy
* Improved ChefSpec default recipe logic

## 1.1.7 - 08/25/2016 - Levon Becker
* Fixed ChefSpec Tests
* Fixed CircleCI Config
* Added Unit tests to travisci and circleci Rake Tasks

## 1.1.6 - 08/21/2016 - Levon Becker
* Added CircleCI configuration
* Added CircleCI Badge to Readme
* Changed name of rake task for TravisCI to travisci
* Finished getting RakeFile Test Kitchen logic wrote and tested
* Changed name of ENV var for iam instance profile in .kitchen.ec2.yml
* Added kitchen-docker gem to Gemfile
* Updated versions to match ChefDK 0.17.17 versions
* Updated Kitchen configs to chef client 12.13.37 + Rakefile foodcritic version to match
* Still working on Rakefile for parsing my filters right. Meaning CircleCI will run the proxy test and fail.

## 1.1.5 - 08/05/2016 - Levon Becker
* Moved Vagrant driver Kitchen config to default
* Added Docker Kitchen config
* Working on Docker discovery logic in ServerSpec files
* Working on Kitchen config in Rakefile still

## 1.1.4 - 07/20/2016 - Levon Becker
* Added Ubuntu to the Vagrant and EC2 Test Kitchen configs
* Conditioned out Selinux and Firewall settings for Ubuntu. Having issues getting them to work. Will revisit later.
* Renamed some serverspec test files to be more generic and work with Winderz

## 1.1.3 - 07/15/2016 - Levon Becker
* Switched to chef_solo since zero tech is now in solo and Chef is deprecating chef_zero
* Bumped Chef Client to the latest 12.12.15 and tested
* Hard setup Gem versions to make TravisCI happy
* Added Environment Variables to Test Kitchen EC2 config to replace any need to edit the YAML and simply script out Env Var changing depending on environment
* Updated Readme with required Environment Variables or acknowledged that you could override with a .kitchen.local.yml config
* Moved SSH EC2 username to specific OS
* Removed quotes for Windows nodeinfo.cmd script

## 1.1.2 - 07/07/2016 - Levon Becker
* Changed the AWS Profile static entry in the kitchen file to use an environment variable so you can script swapping it out in your CLI.
* Added AWS_REGION Env Var usage for kitchen config.
* Renamed .kitchen.virtualbox.yml to .kitchen.vagrant.yml because that's the driver it uses and could be setup for something like VMware Workstation.

## 1.1.1 - 04/19/2016 - Levon Becker
* Finishing serverspec tests and test suites.
* Some code cleanup
* Fixed kitchen configs to load the environment files correctly.
* With the tests I found several minor logic issues I fixed.
* Still working out bug in iptables serverspec for CentOS/RHEL 5.11 check

## 1.1.0 - 04/14/2016 - Levon Becker
* Moved kitchen config attribute overrides to json files under /test/environments and /test/roles.
* Moved data_bags folder to /test/data_bags.
* Moved global attributes (linux & windows) to default.rb attributes file and removed linux/windows level in the hash.
* Consolidated nodeinfo to one attribute since it's the same info for linux and windows.
* Made some more test suites to show how you can disable tasks with attributes in your environment file.
Such as, no firewall configuration or software installation.
* Added some example data bag items that are not currently used.
* Created another kitchen config for when a proxy is needed for virtualbox virtual machines.
* Fixed a couple nodeinfo outputs
* Fixed Detected Environments
* Fixed ICMP syntax for firewall cookbook. Even though it disables ip6tables it still sets the rules. There is a syntax change in ipv6tables.

## 1.0.0 - 04/12/2016 - Levon Becker
* Initial Release
