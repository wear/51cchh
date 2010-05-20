class LandingController < ApplicationController    
  
  def index     
     session[:city] = params[:city] || 'sh'      
     @search = true                    
     set_filter
     @vendors = Vendor.find(:all,:limit => 30,:order => 'sum DESC',:conditions => ['city=?',session[:city]])
     
     respond_to do |wants|
      wants.html {  }
      wants.iphone { }
     end
  end           
  

end
