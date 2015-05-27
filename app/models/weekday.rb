class Weekday
  WEEKDAYS = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

  def initialize(permitted: [], unpermitted: [])
    if permitted.present?
      @permitted = filter(permitted)
      @unpermitted = reverse(permitted)
    else
      @permitted = reverse(unpermitted)
      @unpermitted = filter(unpermitted)
    end
  end

  def permitted
    @permitted
  end

  def unpermitted
    @unpermitted
  end

  private

  def filter(weekdays)
    WEEKDAYS.each_with_object ([]) do |weekday, filtered|
      filtered << weekday if weekdays.map(&:downcase).include?(weekday)
    end
  end

  def reverse(weekdays)
    WEEKDAYS.each_with_object ([]) do |weekday, reversed|
      reversed << weekday if weekdays.map(&:downcase).exclude?(weekday)
    end
  end
end
