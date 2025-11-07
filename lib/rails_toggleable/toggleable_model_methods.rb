# lib/rails_toggleable/toggleable_model_methods.rb
module RailsToggleable
  module ToggleableModelMethods
    # 使用 included 回调来修改包含此模块的模型类
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def toggleable_field(field_name, options = {})
        field_sym = field_name.to_sym
        field_str = field_name.to_s
        default_value = options.fetch(:default, true)

        scope field_sym, -> { where(field_sym => true) }
        scope :"not_#{field_sym}", -> { where(field_sym => false) }

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
      end
    end
    # 实例方法可以放在这里，但当前没有
  end
end