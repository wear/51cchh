module BookingsHelper
  def booktime(time)
    TIMERANGE[time].first
  end
end
