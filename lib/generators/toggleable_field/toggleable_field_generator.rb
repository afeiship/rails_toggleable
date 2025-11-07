# lib/generators/toggleable_field/toggleable_field_generator.rb
class ToggleableFieldGenerator < Rails::Generators::NamedBase
  class_option :model, type: :string, aliases: '-m', desc: "Model to add the field to"

  def field_name
    file_name
  end

  def model_name
    options[:model] || file_name.singularize.classify
  end

  def table_name
    model_name.underscore.pluralize
  end

  def create_migration_file
    # Step 1: 使用 rails generate migration 创建一个带时间戳的空迁移文件
    # 迁移类名通常为 AddFieldNameToTableName (e.g., AddActiveToUsers)
    migration_class_name = "Add#{field_name.camelize}To#{table_name.camelize}"
    
    # 调用 migration generator 创建骨架
    generate "migration", migration_class_name
    
    # Step 2: 找到刚刚生成的、带有最新时间戳的迁移文件
    # Rails generators 将文件添加到 pending 操作中，我们可以从这里获取路径
    # 更可靠的方法是搜索 db/migrate 目录下以该类名结尾的 .rb 文件
    generated_files = Dir.glob(Rails.root.join("db/migrate/*_#{migration_class_name.underscore}.rb"))
    if generated_files.empty?
      abort "Error: Failed to find the generated migration file for #{migration_class_name}."
    end
    
    # 取最新的一个（理论上应该只有一个）
    migration_file_path = generated_files.sort.last
    
    # Step 3: 读取现有内容并插入我们的代码
    content = <<~RUBY
      class #{migration_class_name} < ActiveRecord::Migration[#{migration_version}]
        def change
          add_column :#{table_name}, :#{field_name}, :boolean, default: true
          # Consider adding an index if you frequently query by this field
          # add_index :#{table_name}, :#{field_name}
        end
      end
    RUBY
    
    # 写入新内容
    File.open(migration_file_path, 'w') do |file|
      file.write(content)
    end
    
    # Step 4: 向用户报告
    log "\nUpdated migration file: #{migration_file_path.sub(Rails.root.to_s + '/', '')}"
  end

  private

  def migration_version
    "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
  end

  def show_readme
    log "\n\n"
    log "Next steps:"
    log "1. Review the updated migration file in db/migrate/ for correctness."
    log "2. Run `rails db:migrate` to apply the changes to your database."
    log "3. Add `toggleable_field :#{field_name}, default: true` to your #{model_name} model."
    log "\nExample in app/models/#{model_name.underscore}.rb:"
    log "  class #{model_name} < ApplicationRecord"
    log "    toggleable_field :#{field_name}, default: true # or false, as needed"
    log "  end"
    log "\n"
  end
end