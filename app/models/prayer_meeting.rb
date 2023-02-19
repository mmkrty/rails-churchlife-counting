class PrayerMeeting < ApplicationRecord
  validate :validate_date_is_tuesday
  before_create :calculate_total
  before_save :calculate_total

  private

  def calculate_total
    self.total = adults + teenagers + children + toddlers
  end

  def validate_date_is_tuesday
    errors.add(:date, "must be a Tuesday") unless date.wday == 2
  end
end
