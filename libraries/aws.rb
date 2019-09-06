module BonusBits
  # Discovery Class
  class AWS
    @base_url = 'http://169.254.169.254/latest/meta-data'
    @value_map = {
      'ami-id' => 'ami-id',
      'ami-launch-index' => 'ami-launch-index',
      'ami-manifest-path' => 'ami-manifest-path',
      'block-device-mapping' => 'block-device-mapping/ami',
      'hostname' => 'hostname',
      'instance-action' => 'instance-action',
      'instance-id' => 'instance-id',
      'instance-type' => 'instance-type',
      'local-hostname' => 'local-hostname',
      'local-ipv4' => 'local-ipv4',
      'mac' => 'mac',
      'availability-zone' => 'placement/availability-zone',
      'region' => 'placement/availability-zone',
      'public-hostname' => 'public-hostname',
      'public-ipv4' => 'public-ipv4',
      'reservation-id' => 'reservation-id',
      'security-groups' => 'security-groups',
      'domain' => 'services/domain'
    }

    def self.fetch_metadata(value)
      require 'net/http'
      # Kill if unknown value passed
      raise 'Unknown Metadata Value' unless @value_map.key?(value)

      url = "#{@base_url}/#{@value_map[value]}"
      response = Net::HTTP.get_response(URI(url))
      raise 'Failed AZ HTTP Response' unless response.is_a? Net::HTTPSuccess

      # Parse Region from Availability Zone Return
      if value == 'region'
        response.body.slice(0..-2)
      else
        response.body
      end
    end
  end
end
