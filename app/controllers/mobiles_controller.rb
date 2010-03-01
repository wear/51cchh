class MobilesController < ApplicationController 
  include FaceboxRender   
  # GET /mobiles
  # GET /mobiles.xml
  def index
    @mobiles = Mobile.all

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # GET /mobiles/1
  # GET /mobiles/1.xml
  def show
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mobile }
    end
  end

  # GET /mobiles/new
  # GET /mobiles/new.xml
  def new      
    @vendor = Vendor.find(params[:vendor])
    @mobile = Mobile.new

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @mobile }
    end
  end

  # GET /mobiles/1/edit
  def edit
    @mobile = Mobile.find(params[:id])
  end

  # POST /mobiles
  # POST /mobiles.xml
  def create
    @exist_user = Mobile.find_by_mobile(params[:mobile][:mobile])
    @mobile_user =  @exist_user.nil? ? Mobile.create(:mobile => params[:mobile][:mobile]) : @exist_user 
    @vendor = Vendor.find(params[:vendor_id])
    respond_to do |wants|
      if @mobile_user   
        @res = Hesine::Bundle.bind(:phone => params[:mobile][:mobile])['StatusCode']
        if @res == '405'
          session[:mobile_user] = @mobile_user   
          wants.js { 
            render  :update do |page|  
              page.redirect_to new_vendor_booking_path(@vendor)   
            end
            }
        else
          wants.js { 
            render  :update do |page| 
              page.replace_html 'error_msg', "你需要绑定手机才能预定,绑定短信已发送到你的手机，请按短信提示操作" 
            end
            } 
        end
      else  
        wants.js { 
          render  :update do |page| 
            page.replace_html 'error_msg','手机号码未绑定' 
          end
          }
      end 
    end
  end

  # PUT /mobiles/1
  # PUT /mobiles/1.xml
  def update
    @mobile = Mobile.find(params[:id])

    respond_to do |format|
      if @mobile.update_attributes(params[:mobile])
        flash[:notice] = 'Mobile was successfully updated.'
        format.html { redirect_to(@mobile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mobile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mobiles/1
  # DELETE /mobiles/1.xml
  def destroy
    @mobile = Mobile.find(params[:id])
    @mobile.destroy

    respond_to do |format|
      format.html { redirect_to(mobiles_url) }
      format.xml  { head :ok }
    end
  end
end
