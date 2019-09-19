# rubocop:disable Style/HashSyntax

actions :display_output
default_action :display_output

attribute :name, :kind_of => String, :name_attribute => true
attribute :reports, :kind_of => Array
