# Use like "rake custom:create_test_fixtures[model]"
namespace :fixtures do
    desc 'Re-Creates Fixtures for Testing for a Model'
  
    task :generate, [:model] => [:environment] do |t, args|
      class ActiveRecord::Base
        def dump_fixture
          fixture_file = "#{Rails.root}/test/fixtures/generated_#{self.class.table_name}.yml"
          File.open(fixture_file, "a+") do |f|
            f.puts({"#{self.class.table_name.singularize}_#{id}" => attributes}.
                to_yaml.sub!(/---\s?/, "\n"))
          end
        end
      end
  
      begin
        model = args[:model].constantize
        model.all.map(&:dump_fixture)
        puts "OK: Created Fixture for Model \"#{args[:model]}\"."
      rescue NameError
        puts "ERROR: Model \"#{args[:model]}\" not found."
      end
  
    end
  end
  