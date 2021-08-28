# frozen_string_literal: true

require 'thor'

module Sshify
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'sshify version'
    def version
      require_relative 'version'
      puts "v#{Sshify::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'connect [-c]', 'connect to server'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def connect(*)
      if options[:help]
        invoke :help, ['connect']
      else
        require_relative 'commands/connect'
        Sshify::Commands::Connect.new(options).execute
      end
    end
    map %w(--connect -c) => :connect

    desc 'config [-cf]', 'manage ssh connections'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def config(*)
      if options[:help]
        invoke :help, ['config']
      else
        require_relative 'commands/config'
        Sshify::Commands::Config.new(options).execute
      end
    end
    map %w(--config -cf) => :config
  end
end
