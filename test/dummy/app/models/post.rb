class Post < ApplicationRecord
  toggleable_field :published, default: false
end
