class Rental < ApplicationRecord
    belongs_to :property
    validates :price, presence: true
    validates :number_of_bedrooms, presence:true
end
