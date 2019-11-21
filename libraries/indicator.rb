module BonusBits
  class Indicator
    def self.create_indicator_file(fullname)
      return if ::File.exist?(fullname)

      puts ''
      puts "INFO: Creating Indicator File (#{fullname})"
      puts ''
      ::File.open(fullname, 'w') { |f| f.write(::Time.now.utc.strftime('%Y%m%d-%H%M%S')) }
    end
  end
end
