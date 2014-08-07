class AddOrdinalToItems < ActiveRecord::Migration
  def change
    add_column :items, :ordinal, :integer
  end
end
