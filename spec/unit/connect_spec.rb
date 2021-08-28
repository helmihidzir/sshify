require 'sshify/commands/connect'

RSpec.describe Sshify::Commands::Connect do
  it "executes `connect` command successfully" do
    output = StringIO.new
    options = {}
    command = Sshify::Commands::Connect.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
