class Category < ActiveRecord::Base
  has_ancestry
  # belongs_to :ancestry

  has_many :entries

  # default_scope includes(:ancestry)
  default_scope { order('name asc') } 
  scope :recent, -> { joins("LEFT JOIN (SELECT category_id FROM entries LIMIT 100) limited_entries ON limited_entries.category_id = categories.id").group('categories.id').reorder('count(limited_entries.category_id) desc') }

  def with_root
    self.parent ? name + ' [' + parent.name + ']' : name
  end
end
