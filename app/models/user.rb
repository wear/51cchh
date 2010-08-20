require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_uniqueness_of :mobile
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email,:mobile, :password, :password_confirmation,:locations_attributes

  has_many :bills,:as => :billable
  has_many :bookings, :class_name => "booking", :foreign_key => "mobile"
  has_many :locations
  accepts_nested_attributes_for :locations, :reject_if => proc { |attributes| attributes['name'].blank? }            
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def mobile=(value)
    write_attribute :mobile, (value ? value.downcase : nil)
  end  
  
  
  def self.generate_new_password(length=6)
    charactars = ("a".."z").to_a + ("1".."9").to_a
    (0..length).inject([]) { |password, i| password << charactars[rand(charactars.size-1)] }.join
  end

  protected
    


end
