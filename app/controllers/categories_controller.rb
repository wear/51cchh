class CategoriesController < ApplicationController 
  def show      
    @search = true
    set_filter
    @specify_category = Category.find(params[:id])   
    @a =  generate_category_filter(@specify_category)
    if !params[:query].blank? 
      @search = Vendor.search(generate_category_filter(@specify_category))     
      @vendors = @search.find(:all,:limit => 30)
    else
      @vendors = set_category(@specify_category).find(:all,:limit => 30,:order => 'sum DESC')
    end
  end     
  
  protected
  
  def set_category(cate)
      city_vendors = Vendor.city_equals(session[:city])
      case cate.filter
      when '地区'
       city_vendors.address_like(cate.name)
      when '菜系'  
         city_vendors.category_like(cate.name)
       when '均价'
         case cate.name
         when '51-80' 
           city_vendors.avg_gte(50).avg_lte(80)
         when '81-120'           
           city_vendors.avg_gte(81).avg_lte(140)
        when '121-200'
           city_vendors.avg_gte(141).avg_lte(200)
        when '201元以上'
           city_vendors.avg_gte(200)  
        end
      end
  end 
  
  def generate_category_filter(cate) 
    case cate.filter 
      when '均价' 
       case cate.name
       when '51-80' 
         {:name_like => params[:query],:avg_gte => 50, :avg_lte => 80,:city_equals => session[:city] }
       when '81-120'      
         {:name_like => params[:query],:avg_gte => 81, :avg_lte => 140,:city_equals => session[:city] }     
       when '121-200'
         {:name_like => params[:query],:avg_gte => 141, :avg_lte => 200,:city_equals => session[:city] } 
       when '201元以上'    
         {:name_like => params[:query],:avg_gte => 200,:city_equals => session[:city] }
       end 
     when '地区'
       {:name_like => params[:query],:address_like => @specify_category.name,:city_equals => session[:city] }
     when '菜系'  
        {:name_like => params[:query],:category_like => @specify_category.name,:city_equals => session[:city] }
     end
  end            
  
end
