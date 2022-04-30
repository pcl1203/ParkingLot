#!/usr/bin/env ruby

# frozen_string_literal: true

require './commands'

puts '--------Parking Lot Ticketing--------'
file = ARGV.first
cmd = CommandCatcher.new

if file.nil?
  while cmd.check_status
    option = gets
    cmd.send_command(option)
  end
else
  if File.exist?(file)
    File.open(file).each do |line|
      cmd.send_command(line)
    end
  end
end

puts '--------Thank you for using Parking Lot Ticketing System--------'
