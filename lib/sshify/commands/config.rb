# frozen_string_literal: true

require_relative '../command'
require "tty-prompt"
require "tty-config"

module Sshify
  module Commands
    class Config < Sshify::Command
      def initialize(options)
        @options = options

        @config = TTY::Config.new
        @config.filename = "servers"
        @config.extname = ".yml"
        @config.append_path Dir.home
      end

      def execute(input: $stdin, output: $stdout)
        @config ||= self.class.new(@options).config

        selection = prompt.select("Choose your destiny?") do |menu|
          menu.choice "See config"
          menu.choice "Create new config"
          menu.choice "Add new server"
        end

        case selection
        when "See config"
          watch_config(output)
        when "Create new config"
          create_config(output)
        when "Add new server"
          add_server(output)
        end
      end

      private

      def watch_config(output)
        unless @config.exist?
          output.puts 'No config set'
          return
        end
        output.puts @config.read(format: :yaml)
      end

      def create_config(output)
        project_name = prompt.ask("What is name for project")
        user = prompt.ask("What is name for user")
        server_ip = prompt.ask("What is server ip")

        @config.set(project_name, :user, value: user)
        @config.set(project_name, :server_ip, value: server_ip)
        @config.write(force: true)
        output.puts @config.read(format: :yaml)
      end

      def add_server(output)
        @config.read if @config.persisted?

        project_name = prompt.ask("What is name for project")
        user = prompt.ask("What is name for user")
        server_ip = prompt.ask("What is server ip")

        @config.append(user, to: [project_name, :user])
        @config.append(server_ip, to: [project_name, :server_ip])
        @config.write(force: true)
        output.puts @config.read(format: :yaml)
      end
    end
  end
end
