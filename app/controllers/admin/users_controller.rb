class Admin::UsersController < ApplicationController     
  layout 'admin'                          
  before_filter { |c| c.set_section('users') } 
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 50
  end
end
