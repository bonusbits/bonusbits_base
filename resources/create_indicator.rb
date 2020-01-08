resource_name :create_indicator

property :fullname, String, name_property: true

action :create do
  BonusBits::Indicator.create_indicator_file(new_resource.fullname)
end

default_action :create
