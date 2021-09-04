require_relative 'lib/sshify/version'

Gem::Specification.new do |spec|
  spec.name          = "sshify"
  spec.license       = "MIT"
  spec.version       = Sshify::VERSION
  spec.authors       = ["Helmi Hidzir"]
  spec.email         = ["helmihidzir@gmail.com"]

  spec.summary       = %q{Manage your ssh connections}
  spec.description   = %q{Manage your ssh connections}
  spec.homepage      = "https://github.com/helmihidzir/sshify"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/helmihidzir/sshify"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
