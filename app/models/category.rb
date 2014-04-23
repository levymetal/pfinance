class Category < ActiveRecord::Base
  has_ancestry

  has_many :entries

  default_scope { order('name asc') } 
  scope :recent, -> { joins(:entries).group('categories.id').reorder('count(entries.category_id) desc') }
end
