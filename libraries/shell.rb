module BonusBits
  # Shell Class
  class Shell
    require 'open3'
    def self.run_command(shell_command, sensitive = false)
      # Set sensitive to true if you don't want outputs that may have secrets
      # Run Bash Script and Capture StrOut, StrErr, and Status
      BonusBits::Output.info("Open3: Shell Command (#{shell_command})") unless sensitive
      out, err, status = Open3.capture3(shell_command)
      BonusBits::Output.info("Open3: Status (#{status})")
      BonusBits::Output.info("Open3: Standard Out (#{out})") unless sensitive
      successful = status.success?
      BonusBits::Output.info("Open3: Successful? (#{successful})")
      BonusBits::Output.info("Open3: Error Out (#{err})") unless successful
      successful
    end

    def self.run_command_return_strout(shell_command, sensitive = false)
      # Set sensitive to true if you don't want outputs that may have secrets
      # Run Bash Script and Capture StrOut, StrErr, and Status
      BonusBits::Output.info("Open3: Shell Command (#{shell_command})") unless sensitive
      out, err, status = Open3.capture3(shell_command)
      BonusBits::Output.info("Open3: Status (#{status})")
      BonusBits::Output.info("Open3: Standard Out (#{out})") unless sensitive
      successful = status.success?
      BonusBits::Output.info("Open3: Successful? (#{successful})")
      BonusBits::Output.info("Open3: Error Out (#{err})") unless successful
      out
    end
  end
end
