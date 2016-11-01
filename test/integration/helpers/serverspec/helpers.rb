# helpers

def linux?
  %w(amazon debian redhat ubuntu suse opensuse).include?(os[:family])
end

def amazon?
  os[:family] == 'amazon'
end

def rhel_family?
  %w(redhat amazon).include?(os[:family])
end

def redhat?
  os[:family] == 'redhat'
end

def debian?
  %w(debian).include?(os[:family])
end

def ubuntu?
  %w(ubuntu).include?(os[:family])
end

def suse?
  %w(suse opensuse).include?(os[:family])
end

def windows?
  %w(windows).include?(os[:family])
end

def rhel6?
  redhat? && os[:release].to_f.between?(6.0, 6.9)
end

def rhel7?
  redhat? && os[:release].to_f.between?(7.0, 7.9)
end

def ubuntu1404?
  ubuntu? && release?('14.04')
end

def ubuntu1604?
  ubuntu? && release?('16.04')
end

def release?(test_version)
  os[:release] == test_version
end

def container?
  filename = '/proc/1/cgroup'
  file_contents = ::File.read(filename)
  if file_contents =~ /docker/ || file_contents =~ /lxc/
    true
  else
    false
  end
end
