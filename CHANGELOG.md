##CHANGE LOG
---

##1.1.9 - 10/07/2016 - Levon Becker
* Added example Policyfile (WIP)
* Made node hash consistent
* Updated to Chef client 12.14.89, Ruby 2.3.1 and newer gems included in ChefDK 0.18.30
* Stripped down integration tests in Rakefile
* Ditched coveralls at least for now
* Tested CentOS 6.8
* Switched so regular repo installs before epel repo installed. Usually epel installs are addins to a standard package.

##1.1.8 - 08/29/2016 - Levon Becker
* Improved Docker? method
* Removed the proxy test suites from EC2 and Docker Kitchen Config
* Removed Rubocop config to make CircleCI happy
* Improved ChefSpec default recipe logic

##1.1.7 - 08/25/2016 - Levon Becker
* Fixed ChefSpec Tests
* Fixed CircleCI Config
* Added Unit tests to travisci and circleci Rake Tasks

##1.1.6 - 08/21/2016 - Levon Becker
* Added CircleCI configuration
* Added CircleCI Badge to Readme
* Changed name of rake task for TravisCI to travisci
* Finished getting RakeFile Test Kitchen logic wrote and tested
* Changed name of ENV var for iam instance profile in .kitchen.ec2.yml
* Added kitchen-docker gem to Gemfile
* Updated versions to match ChefDK 0.17.17 versions
* Updated Kitchen configs to chef client 12.13.37 + Rakefile foodcritic version to match
* Still working on Rakefile for parsing my filters right. Meaning CircleCI will run the proxy test and fail.

##1.1.5 - 08/05/2016 - Levon Becker
* Moved Vagrant driver Kitchen config to default
* Added Docker Kitchen config
* Working on Docker discovery logic in ServerSpec files
* Working on Kitchen config in Rakefile still

##1.1.4 - 07/20/2016 - Levon Becker
* Added Ubuntu to the Vagrant and EC2 Test Kitchen configs
* Conditioned out Selinux and Firewall settings for Ubuntu. Having issues getting them to work. Will revisit later.
* Renamed some serverspec test files to be more generic and work with Winderz

##1.1.3 - 07/15/2016 - Levon Becker
* Switched to chef_solo since zero tech is now in solo and Chef is deprecating chef_zero
* Bumped Chef Client to the latest 12.12.15 and tested
* Hard setup Gem versions to make TravisCI happy
* Added Environment Variables to Test Kitchen EC2 config to replace any need to edit the YAML and simply script out Env Var changing depending on environment
* Updated Readme with required Environment Variables or acknowledged that you could override with a .kitchen.local.yml config
* Moved SSH EC2 username to specific OS
* Removed quotes for Windows nodeinfo.cmd script

##1.1.2 - 07/07/2016 - Levon Becker
* Changed the AWS Profile static entry in the kitchen file to use an environment variable so you can script swapping it out in your CLI.
* Added AWS_REGION Env Var usage for kitchen config.
* Renamed .kitchen.virtualbox.yml to .kitchen.vagrant.yml because that's the driver it uses and could be setup for something like VMware Workstation.

##1.1.1 - 04/19/2016 - Levon Becker
* Finishing serverspec tests and test suites.
* Some code cleanup
* Fixed kitchen configs to load the environment files correctly.
* With the tests I found several minor logic issues I fixed.
* Still working out bug in iptables serverspec for CentOS/RHEL 5.11 check

##1.1.0 - 04/14/2016 - Levon Becker
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

##1.0.0 - 04/12/2016 - Levon Becker
* Initial Release
