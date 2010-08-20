class Admin::VendorsController < ApplicationController  
  layout 'admin'                    
  
  def index
    @section = 'vendors' 
    @vendors = Vendor.paginate :page => params[:page], :per_page => 50,:order => 'created_at DESC'
  end            
  
  def new
    @section = 'vendors'
    @vendor = Vendor.new()      
  end 
  
  def show
    @section = 'vendors'   
    @vendor = Vendor.find params[:id]  
  end    
  
  def edit
     @vendor = Vendor.find params[:id]  
  end
  
  def create
    @vendor = Vendor.new(params[:vendor])
    
    respond_to do |wants|
      if @vendor.save                            
        flash[:notice] = '已成功'
        wants.html { redirect_to admin_vendors_path }
      else                        
        @section = 'vendors'  
        wants.html { render :action => "new" }
      end
    end
  end
  
  def update
    @vendor = Vendor.find params[:id]
    
    respond_to do |wants|
      if @vendor.update_attributes(params[:vendor])        
        wants.html { redirect_to admin_vendors_path }
      else
        wants.html { render :action => "edit" }
      end
    end
  end   
       
  def destroy
    @vendor = Vendor.find params[:id]
    @vendor.destroy
    
    respond_to do |wants|
      wants.html { redirect_to admin_vendors_path }
    end
  end
end
