# lib/generators/toggleable_field/toggleable_field_generator.rb
class ToggleableFieldGenerator < Rails::Generators::NamedBase
  argument :field_name, type: :string, desc: "Name of the toggleable boolean field (e.g., active, enabled)"

  class_option :model, type: :string, aliases: '-m', desc: "Model to add the field to"

  def create_migration_file
    model_name = options[:model] || file_name.singularize.classify
    migration_name = "add_#{field_name}_to_#{model_name.underscore.pluralize}"
    field_type_with_default = "#{field_name}:boolean:default:true" # 默认值设为 true

    # 调用 Rails 的 migration generator
    generate "migration", "#{migration_name} #{field_type_with_default}"
  end

  def show_readme
    log "\n\n"
    log "Next steps:"
    log "1. Review the generated migration file in db/migrate/ for correctness."
    log "2. Run `rails db:migrate` to apply the changes to your database."
    log "3. Add `toggleable_field :#{field_name}, default: true` to your #{model_name} model."
    log "\nExample in app/models/#{model_name.underscore}.rb:"
    log "  class #{model_name} < ApplicationRecord"
    log "    toggleable_field :#{field_name}, default: true # or false, as needed"
    log "  end"
    log "\n"
  end
end