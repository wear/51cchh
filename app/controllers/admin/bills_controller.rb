class Admin::BillsController < ApplicationController 
  layout 'admin'                          
  before_filter { |c| c.set_section('commissions') }  
  
  def index
    
  end      
  
  def new

  end
  
  private

  def find_billable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end
