class SmallGroup < ApplicationRecord
  before_validation :calculate_total
  before_save :calculate_total

  private

  def calculate_total
    self.total = adults + teenagers + children
  end
end
