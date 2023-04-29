class RemoveToddlersFromSmallGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :small_groups, :toddlers, :integer
  end
end
