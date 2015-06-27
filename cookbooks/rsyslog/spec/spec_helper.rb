require 'berkshelf'
require 'chefspec'
require 'chef/application' # CHEF-3407

Berkshelf.ui.mute do
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.install(path: 'vendor/cookbooks', only: 'integration')
end
