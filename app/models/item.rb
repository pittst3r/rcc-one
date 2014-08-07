class Item < ActiveRecord::Base
  after_save :make_room, if: :has_existing_ordinal?

  default_scope { order('ordinal ASC') }

  private

  def has_existing_ordinal?
    Item.where('ordinal = ?', ordinal).exists?
  end

  def make_room
    Item.where('ordinal >= ?', ordinal).each do |i|
      i.update_column :ordinal, i.ordinal + 1
    end
  end
end
