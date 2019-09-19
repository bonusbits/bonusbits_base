use_inline_resources

action :display_output do
  ruby_block new_resource.name do
    block do
      BonusBits::Output.header2(new_resource.name)

      new_resource.reports.each do |results|
        # TODO: Change to debug?
        BonusBits::Output.message(results)
      end

      BonusBits::Output.footer2(new_resource.name)
    end
    action :run
  end

  # Notify Observers
  new_resource.updated_by_last_action(true)
end

# Used to force Output When intended and not at start of converge
action :action do
  ruby_block new_resource.name do
    block do
      BonusBits::Output.action(new_resource.name)
    end
    action :run
  end

  # Notify Observers
  new_resource.updated_by_last_action(true)
end
