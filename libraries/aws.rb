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

    def self.check_ec2_status(region, instance_id, indicator_file)
      require 'aws-sdk'
      return if ::File.exist?(indicator_file)

      loop_count = 0
      ec2_instance_status = nil
      ec2_system_status = nil
      until loop_count >= 180 || ec2_instance_status == 'ok' && ec2_system_status == 'ok'
        ec2 = ::Aws::EC2::Client.new(region: region)
        ec2_status_response = ec2.describe_instance_status(instance_ids: [instance_id])
        ec2_instance_status = ec2_status_response.instance_statuses[0].instance_status.status
        ec2_system_status = ec2_status_response.instance_statuses[0].system_status.status
        loop_count += 1
        puts ''
        puts "INFO: EC2 Instance Status (#{ec2_instance_status})"
        puts "INFO: EC2 System Status   (#{ec2_system_status})"
        puts ''
        sleep 5 unless ec2_instance_status == 'ok' && ec2_system_status == 'ok'
      end
      raise 'ERROR: ECS Instance has not returned (ok)!' unless ec2_instance_status == 'ok' && ec2_system_status == 'ok'

      GheBase::Indicator.create_indicator_file(indicator_file)
    end
  end
end
