case node['os']
when 'linux'
  # Set Internal GEM Source
  template '/root/.gemrc' do
    source 'gem_source/gemrc.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
when 'windows'
  return
else
  return
end
