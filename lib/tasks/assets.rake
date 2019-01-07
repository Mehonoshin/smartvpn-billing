# frozen_string_literal: true

namespace :assets do
  desc 'Check that all assets have valid encoding'
  task check: :environment do
    paths = ['app/assets', 'lib/assets', 'vendor/assets']
    extensions = %w[js coffee css scss]

    paths.each do |path|
      dir_path = Rails.root + path

      next unless File.exist?(dir_path)

      dir_files = File.join(dir_path, '**')

      Dir.glob(dir_files + "/**.{#{extensions.join(',')}}").each do |file|
        # make sure we're not trying to process a directory
        next if File.directory?(file)

        # read the file and check its encoding
        data = File.read(file)
        puts "Invalid encoding: #{file}" unless data.valid_encoding?
      end # end Dir.glob

      # end File.exists
    end # end paths.each
  end
end
