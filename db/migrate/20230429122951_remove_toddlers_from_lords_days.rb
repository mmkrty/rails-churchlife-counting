class RemoveToddlersFromLordsDays < ActiveRecord::Migration[7.0]
  def change
    remove_column :lords_days, :toddlers, :integer
  end
end
