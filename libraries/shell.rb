module BonusBits
  # Shell Class
  class Shell
    require 'open3'
    def self.run_command(shell_command, sensitive = false)
      # Will not show output until completed.
      BonusBits::Output.info("Open3: Shell Command (#{shell_command})") unless sensitive
      out, err, status = Open3.capture3(shell_command)
      successful = status.success?
      unless successful
        BonusBits::Output.info("Open3: Status (#{status})")
        BonusBits::Output.info("Open3: Standard Out (#{out})") unless sensitive
        BonusBits::Output.info("Open3: Successful? (#{successful})")
        BonusBits::Output.info("Open3: Error Out (#{err})")
      end
      successful
    end

    def self.run_command_strout(shell_command, sensitive = false)
      # Will not show output until completed.
      BonusBits::Output.info("Open3: Shell Command (#{shell_command})") unless sensitive
      out, err, status = Open3.capture3(shell_command)
      successful = status.success?
      unless successful
        BonusBits::Output.info("Open3: Status (#{status})")
        BonusBits::Output.info("Open3: Standard Out (#{out})") unless sensitive
        BonusBits::Output.info("Open3: Successful? (#{successful})")
        BonusBits::Output.info("Open3: Error Out (#{err})")
      end
      out
    end
  end
end
