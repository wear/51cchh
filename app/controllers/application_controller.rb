# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password   
  include AuthenticatedSystem 
  
  before_filter :adjust_format_for_iphone

  
  def set_filter      
    session[:city] ||= 'sh'
    @categories = Category.find(:all,:conditions => ['city = ?',session[:city]])
    @category_filters = @categories.group_by { |c| c.filter }
  end      
  
  def adjust_format_for_iphone
      request.format = :iphone if iphone_user_agent?
  end     
  
  def iphone_user_agent?
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
  end
     
  
end
