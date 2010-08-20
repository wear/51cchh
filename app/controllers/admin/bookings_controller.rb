class Admin::BookingsController < ApplicationController    
  layout 'admin'
  before_filter { |c| c.set_section('bookings') }      
    
  def index
    @bookings = Booking.find(:all)
  end             
  
  def edit
    @booking = Booking.find(params[:id])
  end  
  
  def update
    @booking = Booking.find(params[:id])
    
    respond_to do |wants|
      if @booking.update_attributes(params[:booking])
        wants.html { redirect_to admin_bookings_path }
      else
        wants.html { render :action => "edit" }
      end
    end
  end 
  
  def destroy
    @booking = Booking.find(params[:id]) 
    @booking.destroy
    
    respond_to do |wants|
      wants.html { redirect_to admin_bookings_path }
    end
    
  end
end
