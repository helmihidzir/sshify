# frozen_string_literal: true

require_relative '../command'
require "tty-prompt"
require "tty-config"

module Sshify
  module Commands
    class Connect < Sshify::Command
      def initialize(options)
        @options = options

        @config = TTY::Config.new
        @config.filename = "sshify-config"
        @config.extname = ".yml"
        @config.append_path Dir.home
      end

      def execute(input: $stdin, output: $stdout)
        @config ||= self.class.new(@options).config
        @config.read if @config.persisted?

        selection = prompt.select("Select one to connect") do |menu|
          @config.read.keys.each do |server_name|
            menu.choice server_name
          end
        end

        server = @config.fetch(selection)
        user = server['user'].first
        server_ip = server['server_ip'].first

        exec("ssh #{user}@#{server_ip}")
      end
    end
  end
end
