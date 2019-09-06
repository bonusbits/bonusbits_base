module BonusBits
  # Console Output Methods
  class Output
    def self.header(description)
      Chef::Log.warn('')
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn("BEGIN: #{description}")
      Chef::Log.warn('------------------------------------------------------------------')
    end

    def self.footer(description)
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn("END: #{description}")
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn('')
    end

    def self.header2(description)
      Chef::Log.warn('')
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn(description)
      Chef::Log.warn('------------------------------------------------------------------')
    end

    def self.footer2(description)
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn(description)
      Chef::Log.warn('------------------------------------------------------------------')
      Chef::Log.warn('')
    end

    def self.announce(description, &_block)
      header(description)
      yield
      footer(description)
    end

    def self.message(message)
      Chef::Log.warn(message)
    end

    def self.report(message)
      Chef::Log.warn("REPORT: #{message}")
    end

    def self.info(message)
      Chef::Log.warn("INFO: #{message}")
    end

    def self.warn(message)
      Chef::Log.warn("WARN: #{message}")
    end

    def self.action(message)
      Chef::Log.warn("ACTION: #{message}")
    end

    def self.error(message)
      Chef::Log.warn("ERROR: #{message}")
    end

    def self.break(message)
      Chef::Log.warn("ERROR: #{message}")
      raise message
    end
  end
end
