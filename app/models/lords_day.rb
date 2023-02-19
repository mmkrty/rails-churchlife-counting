class LordsDay < ApplicationRecord
  validate :validate_date_is_sunday
  before_create :calculate_total
  before_save :calculate_total

  private

  def calculate_total
    self.total = adults + teenagers + children + toddlers
  end

  def validate_date_is_sunday
    errors.add(:date, "must be a Sunday") unless date.wday == 0
  end
end
