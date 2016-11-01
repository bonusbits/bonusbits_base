# Append Attribute Prefix
default['bonusbits_base']['windows'].tap do |windows|
  # Windows Defaults
  windows['setup_powershell'] = true
  windows['setup_winrm'] = true
  windows['add_users'] = true
end
