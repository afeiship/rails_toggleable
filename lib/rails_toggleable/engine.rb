# lib/rails_toggleable/engine.rb
require 'rails'
require_relative 'toggleable_model_methods'

module RailsToggleable
  class Engine < ::Rails::Engine
    isolate_namespace RailsToggleable

    # 将 ToggleableModelMethods 混入 ActiveRecord::Base
    initializer "rails_toggleable.active_record" do
      ActiveSupport.on_load :active_record do
        extend RailsToggleable::ToggleableModelMethods
      end
    end
  end
end