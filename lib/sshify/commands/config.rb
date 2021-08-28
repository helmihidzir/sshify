# frozen_string_literal: true

require_relative '../command'
require "tty-prompt"
require "tty-config"
require "tty-command"

module Sshify
  module Commands
    class Config < Sshify::Command
      def initialize(options)
        @options = options

        @config = TTY::Config.new
        @config.filename = "servers"
        @config.extname = ".yml"
        @config.append_path Dir.home

        @cmd = TTY::Command.new
      end

      def execute(input: $stdin, output: $stdout)
        @config ||= self.class.new(@options).config

        selection = prompt.select("Select one") do |menu|
          menu.choice "See config"
          menu.choice "Create new config"
          menu.choice "Add new server"
          menu.choice "Remove server"
        end

        case selection
        when "See config"
          watch_config(output)
        when "Create new config"
          create_config
        when "Add new server"
          add_server
        when "Remove server"
          remove_server(output)
        end
      end

      private

      def watch_config(output)
        @config.read if @config.persisted?

        unless @config.exist?
          output.puts 'No config set'
          return
        end

        @cmd.run("cat #{@config.location_paths.first}/servers.yml")
      end

      def create_config
        project_name = prompt.ask("What is name for server")
        user = prompt.ask("What is name for user")
        server_ip = prompt.ask("What is server ip")

        @config.set(project_name, :user, value: user)
        @config.set(project_name, :server_ip, value: server_ip)
        @config.write(force: true)

        @cmd.run("cat #{@config.location_paths.first}/servers.yml")
      end

      def add_server
        @config.read if @config.persisted?

        project_name = prompt.ask("What is name for project")
        user = prompt.ask("What is name for user")
        server_ip = prompt.ask("What is server ip")

        @config.append(user, to: [project_name, :user])
        @config.append(server_ip, to: [project_name, :server_ip])
        @config.write(force: true)

        @cmd.run("cat #{@config.location_paths.first}/servers.yml")
      end

      def remove_server(output)
        @config.read if @config.persisted?

        selection = prompt.select("Select one to delete") do |menu|
          @config.read.keys.each do |server_name|
            menu.choice server_name
          end
        end

        answer = prompt.yes?("Are you sure?")
        if answer == true
          @config.delete(selection)
          @config.write(force: true)
          output.puts "#{selection} deleted"
        end

        @cmd.run("cat #{@config.location_paths.first}/servers.yml")
      end
    end
  end
end
