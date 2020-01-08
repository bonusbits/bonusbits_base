# New Custom Resources Syntax 12.5+
# property :name, String, default: 'value'

action :container do
  results = BonusBits::Discovery.container?
  BonusBits::Output.report "Docker?               (#{results})"
end
