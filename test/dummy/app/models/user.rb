class User < ApplicationRecord
  toggleable_field :active, default: true
end
