RSpec.describe "`sshify connect` command", type: :cli do
  it "executes `sshify help connect` command successfully" do
    output = `sshify help connect`
    expected_output = <<-OUT
Usage:
  sshify connect

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
