class Category < ActiveRecord::Base
  has_ancestry

  has_many :entries

  default_scope { order('name asc') } 
  scope :recent, -> { unscoped.joins(:entries).group('categories.id').order('count(entries.category_id) desc') }
end
