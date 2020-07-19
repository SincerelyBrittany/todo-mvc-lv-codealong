class Item < ApplicationRecord
    belongs_to :list #adds methods to my model
    validates :description, presence: true

    STATUS = {
        :incomplete => 0,
        :complete => 1
    }

    def complete?
        # self.status == 1
        self.status == STATUS[:complete]
    end  

    def incomplete?
        # self.status == 0
        self.status == STATUS[:incomplete]
    end 
end
