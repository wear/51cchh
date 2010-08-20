module Admin::VendorsHelper     
  def total_paid(vendor)
    vendor.bookings.map(&:paid).inject(0) { |result, element| result + element }
  end     
  
  def total_commission(vendor)
    vendor.bookings.collect{|v| v.commission}.inject(0) { |result, element| result + element }
  end
end
