require 'refinery'

module Refinery
  module Generators
    autoload :EngineInstaller, File.expand_path('../refinery/generators', __FILE__)

    class Engine < Rails::Engine
      config.after_initialize do
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_generators"
          plugin.hide_from_menu = true
        end
      end
    end
  end
end
