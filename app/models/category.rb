class Category < ActiveRecord::Base
  has_ancestry

  has_many :entries

  default_scope { order('name asc') } 
  scope :recent, -> { joins("LEFT JOIN entries ON entries.category_id = categories.id").group('categories.id').reorder('count(entries.category_id) desc') }

  def with_root
    self.parent ? name + ' [' + parent.name + ']' : name
  end
end
