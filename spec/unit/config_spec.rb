require 'sshify/commands/config'

RSpec.describe Sshify::Commands::Config do
  it "executes `config` command successfully" do
    output = StringIO.new
    options = {}
    command = Sshify::Commands::Config.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
