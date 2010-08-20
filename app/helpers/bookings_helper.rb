module BookingsHelper
  def booktime(time)
    TIMERANGE[time].first
  end       
  
  def total_customer_paid(bookings)
    bookings.map(&:paid).inject(0) { |result, element| result + element } 
  end              
  
  def total_customer_commission(bookings)
    bookings.collect{|c| c.commission }.inject(0) { |result, element| result + element } 
  end
end
