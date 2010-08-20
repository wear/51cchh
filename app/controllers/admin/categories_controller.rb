class Admin::CategoriesController < ApplicationController
  layout 'admin'  
  
  def index                
    @section = 'filters'    
    @categories = Category.find(:all)
  end  
  
  def new
     @category = Category.new
  end  
  
  def create
    @category = Category.new(params[:category])
    
    respond_to do |wants|
      if @category.save
        wants.html { redirect_to admin_categories_path }
      else
        wants.html { render :action => "new" }
      end
    end
  end     
  
  def edit
    @category = Category.find(params[:id]) 
  end   
  
  def update
    @category = Category.find(params[:id])
    
    respond_to do |wants| 
      if @category.update_attributes(params[:category])
        wants.html { redirect_to admin_categories_path }
      else
        wants.html { render :action => "edit" }
      end
    end
    
  end
  
  def reset_count
  #  ['bj','sh'].each do |city|
      Category.city_equals('bj').each do |city_cate|
        case city_cate.filter
        when '地区'
          city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').address_like(city_cate.name).length) 
        when '菜系'  
        #  case city_cate.name
        #    when '面包甜点'        
        #      city_cate.update_attributes(:vendors_count => Vendor.category_equals('面包').length)    
        #    when '自助餐'                       
        #      city_cate.update_attributes(:vendors_count => Vendor.category_equals('自助').length) 
        #    when '新疆清真' 
        #      city_cate.update_attributes(:vendors_count => Vendor.category_like('新疆').length)
        #    when '小吃简餐'
        #      city_cate.update_attributes(:vendors_count => Vendor.category_like('小吃').length)
        #    else                                            
              city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').category_like(city_cate.name).length)
        #   end
         when '均价'
           case city_cate.name
           when '51-80' 
            city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').avg_gte(50).avg_lte(80).count)
           when '81-120'           
            city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').avg_gte(81).avg_lte(120).count)
          when '121-200'
            city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').avg_gte(121).avg_lte(200).count)
          when '201元以上'
            city_cate.update_attributes(:vendors_count => Vendor.city_equals('bj').avg_gt(200).count)  
          end
        end
   #   end
    end
    
    respond_to do |wants|
      wants.html { redirect_to admin_categories_path }
    end
  end     
  
  def destroy
    @cate = Category.find(params[:id])
    @cate.destroy
    
    respond_to do |wants|                           
      flash[:notice] = '已删除'
      wants.html { redirect_to admin_categories_path }
    end
  end
  
end
