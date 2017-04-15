FROM amazonlinux:latest
MAINTAINER Levon Becker "levon.docker@bonusbits.com"

# Build Cookbook Args
#ARG chef_client_version=12.19.36
ARG chefdk_version=1.3.40
ARG cookbook_name=bonusbits_base
ARG chef_role=base
ARG chef_environment=bonusbits_base
ARG chef_config_path=/opt/chef-repo

LABEL version="2.1.8" \
      description="Amazon Linux Image built from bonusbits_base cookbook." \
      github="https://github.com/bonusbits/bonusbits_base" \
      website="https://www.bonusbits.com"

# Install Basics
RUN yum clean all
RUN yum update -y --exclude=kernel*
RUN yum install -y git htop mlocate net-tools openssh-client openssh-server procps upstart util-linux vim-enhanced which

# Install Chef Client
#RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${chef_client_version}
# Install ChefDK
## Less work then chef-client install because everything for testing and berkshelf is included.
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -v ${chefdk_version}

# Setup Chef Client
RUN mkdir -p ${chef_config_path}
WORKDIR ${chef_config_path}
RUN mkdir -p cookbooks checksums environments cache backup data_bags roles
RUN mkdir cookbooks/${cookbook_name}
COPY . cookbooks/${cookbook_name}/
COPY test/roles/* roles/
COPY test/environments/* environments/
COPY test/data_bags/* data_bags/
COPY test/node/client.rb ${chef_config_path}/client.rb

# Download Dependant Cookbooks
WORKDIR ${chef_config_path}/cookbooks/${cookbook_name}
RUN /opt/chefdk/bin/berks install
RUN /opt/chefdk/bin/berks vendor ${chef_config_path}/cookbooks/

# Run Chef
RUN /opt/chefdk/bin/chef-client -z --config ${chef_config_path}/client.rb -o "role[${chef_role}]" --environment "${chef_environment}" --log_level info --force-formatter --chef-zero-port 8889

# Run Chef when Container Created
WORKDIR ${chef_config_path}
#ENTRYPOINT ["/bin/bash --login"]
#CMD ["/bin/sh", "-c", "/opt/chefdk/bin/chef-client", "-z", "--config /opt/chef-repo/client.rb", "-o 'role[base]'", "--environment 'bonusbits_base'", "--log_level info", "--force-formatter", "--chef-zero-port 8889"]
#CMD /opt/chefdk/bin/chef-client -z --config /opt/chef-repo/client.rb -o "role[base]" --environment "bonusbits_base" --log_level info --force-formatter --chef-zero-port 8889

#EXPOSE 22