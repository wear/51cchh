class Booking < ActiveRecord::Base   
  belongs_to :vendor, :counter_cache => true 
  belongs_to :user, :class_name => "User", :foreign_key => "mobile", :counter_cache => true

  belongs_to :bookable, :polymorphic => true   
  
  validates_numericality_of :paid,:customer_discount,:system_discount
   
#  belongs_to :discount
  
#  has_many :points, :as => 'charge'
  
  named_scope :lastest_create, :order => 'created_at ASC',:limit => 10
  
  validates_presence_of :date
  validates_presence_of :time_range
  validates_numericality_of :guest_count
  
  validates_presence_of     :contact 
  
  validates_format_of       :mobile, :with => /^13[0-9]|^15[0-9][0-9]{8}$/ 

  acts_as_state_machine :initial => :pending, :column => 'status'

  state :pending 
  # need to send a sms message to user
  state :running#,:enter => :send_sms
  state :closed

  event :run do
    transitions :to => :running, :from => :pending
  end

  event :close do
    transitions :to => :closed, :from => :running
  end 
        
  def commission
    (paid * (vendor.customer_discount +  vendor.system_discount)/10).to_i
  end 
  
  def send_sms
    Hesine::Message.send(:phone => self.mobile,:from => '"客服"<support@wycchh>',:to => "#{mobile}@wycchh",
    :subject => '您在无忧吃吃喝喝的餐馆预定成功',:body => "餐馆名称:#{vendor.name},地址:#{self.vendor.address}.就餐人数:#{self.guest_count},就餐时间:#{self.date} #{format_time_range(self.time_range)}.预定联系人:#{self.contact}")
  end
  
  
  def validate
    unless self.mobile.to_s.size == 11
      errors.add(:mobile, "should be 11 digits")
    end
  end   
  
  private
  
  def format_time_range(range)
    case range
    when 0
      '早市'
    when 1
      '午市'
    when 2
      '晚市'
    end
  end
end
