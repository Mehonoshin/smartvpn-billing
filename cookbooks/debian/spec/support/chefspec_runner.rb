# @return [ChefSpec::ChefRunner] a ChefSpec runner for the specified Debian platform
def debian_runner(version, &block)
  ChefSpec::Runner.new(
    platform: 'debian', version: version,
    step_into: ['debian_repository', 'apt_repository'],
    &block)
end
