module Admin::BookingsHelper
  
  def payback(booking)
      (booking.paid*booking.vendor.customer_discount/10).to_i
  end 
  
  def payus(booking)
      (booking.paid*booking.vendor.system_discount/10).to_i
  end
end
