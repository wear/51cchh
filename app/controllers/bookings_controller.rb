class BookingsController < ApplicationController   
  before_filter :find_vendor   
  before_filter :login_required
  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.find(:all,:conditions => ['mobile = ?',current_user.mobile])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  def show
    @booking = Booking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
    end
  end 
  
  def run     
    @booking = Booking.find(params[:id])  
    respond_to do |wants|               
      if @booking.run!
        wants.html {  } 
      else
        wants.html { redirect_to '/' }  
      end
    end
  end

  # GET /bookings/new
  # GET /bookings/new.xml
  def new     
    @vendor = Vendor.find(params[:vendor_id])
    @booking = Booking.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    @booking = Booking.new(params[:booking])

    respond_to do |format|
      if @booking.save
        format.html { redirect_to(vendor_booking_path @vendor,@booking) }
        format.xml  { render :xml => @booking, :status => :created, :location => @booking }
      else    
        flash[:error] = '有错误发生,请检查表单格式是否正确!'
        format.html { render :action => "new" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update
    @booking = Booking.find(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        flash[:notice] = 'Booking was successfully updated.'
        format.html { redirect_to(vendor_booking_path @vendor,@booking) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.xml
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_vendor
    @vendor = Vendor.find(params[:vendor_id]) if params[:vendor_id]
  end
  

end
