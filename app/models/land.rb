class Land < ApplicationRecord
    belongs_to :property
    validates :land_area, presence:true
end
