class Mobile < ActiveRecord::Base                   
  
  validates_numericality_of :mobile
  validates_format_of :mobile, :with => /^13[0-9]|^15[0-9][0-9]{8}$/
  validates_uniqueness_of :mobile
end
