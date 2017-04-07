FROM amazonlinux:latest
MAINTAINER Levon Becker "levon.docker@bonusbits.com"
ENTRYPOINT ["/bin/bash"]

# Build Cookbook Args
ARG chef_client_version=12.18.31
ARG cookbook_name=bonusbits_base
ARG chef_role=base
ARG build_environment=bonusbits_base

# Create Container Args
ARG deploy_environment=bonusbits_base_aws

# Install Basics
RUN yum clean all
RUN yum update -y --exclude=kernel*
RUN yum install -y sudo upstart procps util-linux openssh-server openssh-clients which curl vim-enhanced openssl ca-certificates mlocate passwd net-tools htop git gzip aws-cfn-bootstrap aws-cli cloud-init

# Bash Profile Basics

# Install Chef Client
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${chef_client_version}

# Setup Chef Client
RUN mkdir -p /opt/chef-repo
WORKDIR /opt/chef-repo
RUN mkdir -p cookbooks checksums environments cache backup data_bags roles
RUN mkdir cookbooks/${cookbook_name}
COPY . cookbooks/${cookbook_name}/
RUN cp -R cookbooks/${cookbook_name}/test/data_bags/${cookbook_name} data_bags/
RUN cp cookbooks/${cookbook_name}/test/roles/${chef_role}.json roles/${chef_role}.json
COPY test/environments/*.json /opt/chef-repo/environments/
COPY test/data_bags/* /opt/chef-repo/data_bags/
COPY test/node/client.rb /opt/chef-repo/client.rb

WORKDIR /opt/chef-repo/cookbooks/${cookbook_name}
RUN yum groupinstall -y "Development Tools"
RUN /opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc
RUN /opt/chef/embedded/bin/berks install
RUN /opt/chef/embedded/bin/berks vendor /opt/chef-repo/cookbooks/

# Run Chef
RUN /opt/chef/bin/chef-client -z --config /opt/chef-repo/client.rb -o recipe[${cookbook_name}] --environment ${build_environment} --log_level info --force-formatter --chef-zero-port 8889

# Run InSpec Integration Tests
#RUN /opt/chef/bin/inspec exec --color --profiles-path=/opt/chef-repo/cookbooks/${cookbook_name}/test/integration/inspec/profiles/bonusbits_web/ --attrs=role=web deployment_type=docker inside_aws=false

# Run Chef and InSpec when Container Created in AWS
CMD ["/opt/chef/bin/chef-client", "-z", "--config /opt/chef-repo/client.rb", "-o recipe[${cookbook_name}]", "--environment ${deploy_environment}", "--log_level info", "--force-formatter", "--chef-zero-port 8889"]
#CMD /opt/chef/bin/inspec exec --color --profiles-path=/opt/chef-repo/cookbooks/${cookbook_name}/test/integration/inspec/profiles/bonusbits_web/ --attrs=role=web deployment_type=docker inside_aws=true

EXPOSE 80 443