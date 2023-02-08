class PrayerMeeting < ApplicationRecord
  before_save :calculate_total

  private

  def calculate_total
    self.total = adults + teenagers + children + toddlers
  end
end
