# Guardfile
# More info at https://github.com/guard/guard#readme

guard 'foodcritic', :cookbook_paths => '.' do
  [ 'metadata\.rb',
    '(attributes|definitions|libraries|providers|recipes|resources)/.+\.rb',
    'templates/.+\.erb'
  ].each do |pattern|
    watch(%r{^#{pattern}$})
  end
end

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }

  watch(%r{^recipes/(.+)\.rb}) { |m| "spec/recipes/#{m[1]}_spec.rb" }
  %w[attributes files libraries providers resources templates].each do |dir|
    watch(%r{^#{dir}/(.+)\.rb$}) { 'spec' }
  end
end
