class Vendor < ActiveRecord::Base 
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :phone
  
  has_many :ratings      
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng


  before_save :cal_sum                 
  has_many :bookings    
  has_many :bills,:as => :billable  
  
  def cal_sum
   self.sum = (service + taste + env)/6
  end       
  
end
