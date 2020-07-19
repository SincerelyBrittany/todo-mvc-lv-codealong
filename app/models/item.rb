class Item < ApplicationRecord
    belongs_to :list #adds methods to my model
    validates :description, presence: true
end
