class BrandProfile < ActiveRecord::Base
  belongs_to :brand
  belongs_to :profile
end
