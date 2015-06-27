# config/backup/config.rb

# since we are stroring the backup config with the project files and not on the server
#  it is a good idea to keep track of the project root
FS_ROOT = Dir.pwd

# * * * * * * * * * * * * * * * * * * * *
#        Do Not Edit Below Here.
# All Configuration Should Be Made Above.

##
# Load all models from the models directory.

Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
