# Guardfile
# guard :rails, port: 3000 do
#   watch('Gemfile.lock')
#   watch(%r{^(config|lib)/.*})
# end

guard :rspec, cmd: "bin/rspec", all_on_start: true, failed_mode: :keep do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # Run all specs when starting
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/rails_helper\.rb$}) { dsl.spec_dir }
  watch(%r{^spec/spec_helper\.rb$}) { dsl.spec_dir }

  # Automatically test models when edited
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }

  # Automatically test controllers when edited
  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    "spec/requests/#{m[1]}_spec.rb"
  end

  # Automatically test helpers
  watch(%r{^app/helpers/(.+)_helper\.rb$}) do |m|
    "spec/helpers/#{m[1]}_helper_spec.rb"
  end

  # Watch routes.rb or factories
  watch('config/routes.rb') { dsl.spec_dir }
  watch(%r{^spec/factories/.+\.rb$}) { dsl.spec_dir }

  # Test features if views change
  watch(%r{^app/views/.+\.(erb|haml|slim)$}) { dsl.spec_dir }

  # Custom matchers
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
end
