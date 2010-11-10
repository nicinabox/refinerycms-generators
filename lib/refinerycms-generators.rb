require 'refinery'

module Refinery
  module Generators
    class Engine < Rails::Engine
      config.to_prepare do
        # We need to help out older versions by giving them future functionality.
        if Refinery.version < '0.9.9'
          module Generators
            # The core engine installer streamlines the installation of custom generated
            # engines. It takes the migrations and seeds in your engine and moves them
            # into the rails app db directory, ready to migrate.
            class EngineInstaller < Rails::Generators::Base
              include Rails::Generators::Migration

              def self.engine_name(name = nil)
                @engine_name = name unless name.nil?
                @engine_name
              end

              # Implement the required interface for Rails::Generators::Migration.
              # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
              # can be removed once this issue is fixed:
              # # https://rails.lighthouseapp.com/projects/8994/tickets/3820-make-railsgeneratorsmigrationnext_migration_number-method-a-class-method-so-it-possible-to-use-it-in-custom-generators
              def self.next_migration_number(dirname)
                if ActiveRecord::Base.timestamped_migrations
                  Time.now.utc.strftime("%Y%m%d%H%M%S")
                else
                  "%.3d" % (current_migration_number(dirname) + 1)
                end
              end

              def generate
                Dir.glob(File.expand_path(File.join(self.class.source_root, '../db/**/**'))).each do |path|
                  unless File.directory?(path)
                    if path =~ /.*migrate.*/
                      migration_template path, Rails.root.join("db/migrate/#{path.split(File::SEPARATOR).last.split('.rb').first}")
                    else
                      template path, Rails.root.join("db/seeds/#{path.split(File::SEPARATOR).last}")
                    end
                  end
                end

                puts "------------------------"
                puts "Now run:"
                puts "rake db:migrate"
                puts "------------------------"
              end
            end
          end
        end
      end

      config.after_initialize do
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_generators"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end
