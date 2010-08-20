class AdminController < ApplicationController  
  layout 'admin'  
  before_filter :redrect_if_not_admin
end
