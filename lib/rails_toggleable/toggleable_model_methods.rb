# lib/rails_toggleable/toggleable_model_methods.rb
module RailsToggleable
  module ToggleableModelMethods
    extend ActiveSupport::Concern

    class_methods do
      def toggleable_field(field_name, options = {})
        field_sym = field_name.to_sym
        field_str = field_name.to_s
        default_value = options.fetch(:default, true) # 默认值

        # --- 1. 定义作用域 ---
        scope field_sym, -> { where(field_sym => true) }
        scope :"not_#{field_sym}", -> { where(field_sym => false) }

        # --- 2. 定义实例方法 ---
        define_method "#{field_str}?" do
          self.send(field_sym)
        end

        define_method "enable_#{field_str}!" do
          update!(field_sym => true)
        end

        define_method "disable_#{field_str}!" do
          update!(field_sym => false)
        end

        define_method "toggle_#{field_str}!" do
          update!(field_sym => !self.send(field_sym))
        end

        # --- 3. 设置默认值 (可选，通常在数据库迁移中设置更佳) ---
        # after_initialize -> { self[field_sym] = default_value if self[field_sym].nil? }
        # 注意：强烈建议在数据库迁移中设置默认值，而不是在应用层面。
        # 例如: rails generate migration AddActiveToUsers active:boolean:default:true
      end
    end
  end
end