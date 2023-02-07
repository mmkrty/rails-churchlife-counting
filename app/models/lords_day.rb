class LordsDay < ApplicationRecord
  validate :validate_date_is_sunday

  private

  def validate_date_is_sunday
    errors.add(:date, "must be a Sunday") unless date.wday == 0
  end
end
