case node['os']
when 'linux'
  # Automatic Shutdown for Kitchen Instances
  cron 'Automatic Shutdown' do
    minute node['bonusbits_base']['kitchen_shutdown']['minute'].to_s
    hour node['bonusbits_base']['kitchen_shutdown']['hour'].to_s
    user 'root'
    command 'shutdown -h now >/dev/null 2>&1'
  end
else
  return
end
