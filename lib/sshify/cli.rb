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

    desc 'config', 'Command description...'
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
  end
end
