FROM amazonlinux:2018.03.0.20190826-with-sources
# Amazon Linux AMI 2018.03 (v1 - el6)
# https://hub.docker.com/_/amazonlinux
MAINTAINER Levon Becker "levon.docker@bonusbits.com"
LABEL version="3.0.0" \
      description="Amazon Linux Image built from bonusbits_base cookbook." \
      github="https://github.com/bonusbits/bonusbits_base" \
      website="https://www.bonusbits.com"

# Build Cookbook Args
#ARG chef_client_version=15.2.20
ARG chefdk_version=4.4.27
ARG cookbook_name=bonusbits_base
ARG chef_role=base
ARG chef_environment=bonusbits_base
ARG chef_config_path=/etc/chef

# Install Basics
RUN yum clean all \
    && yum update -y --exclude=kernel* \
    && yum install -y curl git htop iotop net-tools openssh-clients openssh-server \
    procps sudo upstart util-linux vim-enhanced vim-minimal which

# Install Chef Client
#RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v ${chef_client_version}
# Install ChefDK
## Less work then chef-client install because everything for testing and berkshelf is included.
## https://packages.chef.io/files/stable/chefdk/4.4.27/el/6/chefdk-4.4.27-1.el6.x86_64.rpm
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P chefdk -v ${chefdk_version}

# Setup Chef Client
RUN mkdir -p ${chef_config_path}
WORKDIR ${chef_config_path}
RUN mkdir -p cookbooks/${cookbook_name} checksums environments cache backup data_bags roles
COPY . cookbooks/${cookbook_name}/
COPY test/roles/* roles/
COPY test/environments/* environments/
COPY test/data_bags/* data_bags/
COPY test/node/client.rb ${chef_config_path}/client.rb

# Download Dependant Cookbooks
WORKDIR ${chef_config_path}/cookbooks/${cookbook_name}
RUN /opt/chefdk/bin/berks install && /opt/chefdk/bin/berks vendor ${chef_config_path}/cookbooks/

# Run Chef
# /opt/chefdk/bin/chef-client -z --chef-license accept --config /etc/chef/client.rb -o "role[base]" --environment "bonusbits_base" --log_level info --force-formatter --chef-zero-port 8889
RUN /opt/chefdk/bin/chef-client -z --chef-license accept --config ${chef_config_path}/client.rb -o "role[${chef_role}]" --environment "${chef_environment}" --log_level info --force-formatter --chef-zero-port 8889

# Run Chef when Container Created
#WORKDIR ${chef_config_path}
#ENTRYPOINT [/opt/chefdk/bin/chef-client -z --chef-license accept --config ${chef_config_path}/client.rb -o "role[${chef_role}]" --environment "${chef_environment}" --log_level info --force-formatter --chef-zero-port 8889]
#CMD ["/bin/sh", "-c", "/opt/chefdk/bin/chef-client", "-z", "--config /etc/chef/client.rb", "-o 'role[base]'", "--environment 'bonusbits_base'", "--log_level info", "--force-formatter", "--chef-zero-port 8889"]
#CMD /opt/chefdk/bin/chef-client -z --config /etc/chef/client.rb -o "role[base]" --environment "bonusbits_base" --log_level info --force-formatter --chef-zero-port 8889

#EXPOSE 22