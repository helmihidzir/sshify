RSpec.describe "`sshify config` command", type: :cli do
  it "executes `sshify help config` command successfully" do
    output = `sshify help config`
    expected_output = <<-OUT
Usage:
  sshify config

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
