module BonusBits
  # File System Class
  class File
    # Used to make sure check is executed at correct time / order
    def self.exist?(file_path)
      ::File.exist?(file_path)
    end

    def self.set_path_ownership(user, group, path, recursive = false)
      # TODO: Add Check Logic? Prior to setting ownership; check ownership and only change if needed?
      # TODO: Work with Windows?
      require 'fileutils'
      if recursive
        FileUtils.chown_R user, group, path, verbose: true
        BonusBits::Output.report("Recursively Set (#{user}:#{group}) ownership for (#{path}/*)")
      else
        FileUtils.chown user, group, Dir.glob("#{path}/*")
        BonusBits::Output.report("Set (#{user}:#{group}) ownership for (#{path}/*)")
      end
    end

    def self.set_file_ownership(user, group, fullname)
      require 'fileutils'
      FileUtils.chown user, group, fullname
      BonusBits::Output.report("Set (#{user}:#{group}) ownership for (#{fullname})")
    end
  end
end
