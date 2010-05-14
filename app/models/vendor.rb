class Vendor < ActiveRecord::Base
  has_many :ratings      
  acts_as_mappable

  
end
