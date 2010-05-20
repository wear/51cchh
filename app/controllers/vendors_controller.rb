class VendorsController < ApplicationController
  # GET /vendors
  # GET /vendors.xml
  def index        
    @search = true                    
    set_filter
    @search = Vendor.search(:name_like => params[:query],:city_equals => session[:city])     
    @vendors = @search.find(:all,:limit => 30)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendors }
    end
  end     
  
  def get_nearby
    @vendors = Vendor.find(:all,:origin =>[params[:lat],params[:lng]],
                           :conditions => "distance < 0.8")
    
    respond_to do |wants|
      wants.js {  } 
      wants.iphone { 
       render :update do |page|
        page.replace_html 'vendors',:partial => '/shared/ivendor',:locals => {:vendors => @vendors }
       end 
      }
    end
  end

  # GET /vendors/1
  # GET /vendors/1.xml
  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.iphone { render :layout => false }
      format.xml  { render :xml => @vendor }
    end
  end

  # GET /vendors/new
  # GET /vendors/new.xml
  def new
    @vendor = Vendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendor }
    end
  end

  # GET /vendors/1/edit
  def edit
    @vendor = Vendor.find(params[:id])
  end

  # POST /vendors
  # POST /vendors.xml
  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        flash[:notice] = 'Vendor was successfully created.'
        format.html { redirect_to(@vendor) }
        format.xml  { render :xml => @vendor, :status => :created, :location => @vendor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vendors/1
  # PUT /vendors/1.xml
  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        flash[:notice] = 'Vendor was successfully updated.'
        format.html { redirect_to(@vendor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.xml
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to(vendors_url) }
      format.xml  { head :ok }
    end
  end
end
