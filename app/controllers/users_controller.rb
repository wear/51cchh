class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
    @user = User.new
  end 
  
  def new_mobile   
    @mobile_user = User.new
    @vendor = Vendor.find(params[:vendor_id]) 
    respond_to do |wants|
      wants.html {  }
      wants.js { render :layout => false }
    end
  end        
  
  def get_password  
    set_user_by_mobile(params[:mobile])
    respond_to do |wants|                     
      if Hesine::Bundle.bind(:phone => @user.mobile)['StatusCode'] == '405'
        reset_password
        @res = Hesine::Message.send(:phone => @user.mobile,:from => '"无忧吃吃喝喝客服"<support@wycchh>',:to => "#{@user.mobile}@wycchh",
        :subject => '您在无忧吃吃喝喝的密码',:body => "您的密码为#{@pwd}")
        wants.js {  render :text => '密码已发送到您的手机'  } 
       else
        wants.js{  render :text => '你需要绑定手机才能预定,绑定短信已发送到你的手机，请按短信提示操作'  }  
      end
    end
  end
  
  def create_mobile
    @vendor = Vendor.find(params[:vendor_id])    
    set_user_by_mobile(params[:user][:mobile])
    respond_to do |wants| 
      if Hesine::Bundle.bind(:phone => @user.mobile)['StatusCode'] == '405'
        self.current_user = @user
        wants.js { 
          render  :update do |page|  
            page.redirect_to new_vendor_booking_path(@vendor)   
          end
         }
       else
        wants.js{ 
          render  :update do |page| 
            page.replace_html 'error_msg', "你需要绑定手机才能预定,绑定短信已发送到你的手机，请按短信提示操作" 
            page.show  'error_msg'
          end
        }
       end
    end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  protected     
  
  def reset_password     
    @pwd = User.generate_new_password(6)
    @user.update_attributes(:password => @pwd,:password_confirmation => @pwd)
  end
  
  def set_user_by_mobile(mobile)
    @user = if User.find_by_mobile(mobile)
       User.find(:first,:conditions => ['mobile = ?', mobile])
    else
      pwd = User.generate_new_password
      User.create!(:mobile => mobile,:login => mobile, :password => pwd,:password_confirmation => pwd)     
    end
  end      

  
end
