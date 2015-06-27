require 'foodcritic'
require 'rspec/core/rake_task'
require 'tailor/rake_task'

# emeril gem is not found on the CI
begin
  require 'emeril/rake'
rescue LoadError; end

desc 'Run all tests'
task :default => [:foodcritic, :knife, :spec, :tailor]

FoodCritic::Rake::LintTask.new do |t|
  t.options = { :fail_tags => %w[~FC017] }
end

desc 'Run Knife cookbook tests'
task :knife do
  dirname = File.basename(File.dirname(__FILE__))
  sh 'knife', 'cookbook', 'test', dirname, '--cookbook-path', '..'
end

desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new

Tailor::RakeTask.new do |t|
  t.file_set('metadata.rb', 'metadata')

  %w[attributes definitions libraries providers recipes resources].each do |dir|
    t.file_set("#{dir}/**/*.rb", dir) do |style|
      style.max_line_length 120, :level => :warn
      style.spaces_after_comma 1, :level => :off
    end
  end

  t.file_set('spec/**/*.rb', 'tests') do |style|
    style.max_line_length 120, :level => :warn
  end
end
